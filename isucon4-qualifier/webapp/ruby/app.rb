require 'sinatra/base'
require 'digest/sha2'
require 'mysql2-cs-bind'
require 'rack-flash'
require 'json'
require 'redis'
require 'erubis'

module Isucon4
  class App < Sinatra::Base
    use Rack::Session::Cookie, secret: ENV['ISU4_SESSION_SECRET'] || 'shirokane'
    use Rack::Flash
    set :public_folder, File.expand_path('../../public', __FILE__)

    helpers do
      def config
        @config ||= {
          user_lock_threshold: (ENV['ISU4_USER_LOCK_THRESHOLD'] || 3).to_i,
          ip_ban_threshold: (ENV['ISU4_IP_BAN_THRESHOLD'] || 10).to_i,
        }
      end

      def db
        Thread.current[:isu4_db] ||= Mysql2::Client.new(
          host: ENV['ISU4_DB_HOST'] || 'localhost',
          port: ENV['ISU4_DB_PORT'] ? ENV['ISU4_DB_PORT'].to_i : nil,
          username: ENV['ISU4_DB_USER'] || 'root',
          password: ENV['ISU4_DB_PASSWORD'],
          database: ENV['ISU4_DB_NAME'] || 'isu4_qualifier',
          reconnect: true,
        )
      end

      def calculate_password_hash(password, salt)
        Digest::SHA256.hexdigest "#{password}:#{salt}"
      end

      def redis
        Redis.current = Redis.new(host: "redis", port: 6379)
      end

      def redis_key_user(user)
        "isu4:user:#{user['login']}"
      end

      def redis_key_last(user)
        "isu4:last:#{user['login']}"
      end

      def redis_key_nextlast(user = {'id' => '*'})
        "isu4:nextlast:#{user['login']}"
      end

      def redis_key_ip(ip)
        "isu4:ip:#{ip}"
      end

      def login_log(succeeded, login, user = nil)
        kuser = user && redis_key_user(user)
        kip = redis_key_ip(request.ip)

        if succeeded
          klast, knextlast = redis_key_last(user), redis_key_nextlast(user)
          redis.set kip, 0
          redis.set kuser, 0

          if redis.exists(knextlast)
            redis.rename(knextlast, klast)
          end
          redis.hmset knextlast, 'at', Time.now.to_i, 'ip', request.ip
        else
          redis.incr kip
          redis.incr kuser
        end
      end

      def user_locked?(user)
        failures = redis.get(redis_key_user(user))
        failures = failures && failures.to_i
        failures && config[:user_lock_threshold] <= failures
      end

      def ip_banned?
        failures = redis.get(redis_key_ip(request.ip))
        failures = failures && failures.to_i
        failures && config[:ip_ban_threshold] <= failures
      end

      def attempt_login(login, password)
        user = db.xquery('SELECT * FROM users WHERE login = ?', login).first

        if ip_banned?
          login_log(false, login, user)
          return [nil, :banned]
        end

        if user_locked?(user)
          login_log(false, login, user)
          return [nil, :locked]
        end

        if user && calculate_password_hash(password, user['salt']) == user['password_hash']
          login_log(true, login, user)
          [user, nil]
        elsif user
          login_log(false, login, user)
          [nil, :wrong_password]
        else
          login_log(false, login)
          [nil, :wrong_login]
        end
      end

      def current_user
        return @current_user if @current_user
        return nil unless session[:user_id]

        @current_user = db.xquery('SELECT * FROM users WHERE id = ?', session[:user_id].to_i).first
        unless @current_user
          session[:user_id] = nil
          return nil
        end

        @current_user
      end

      def last_login
        cur = current_user
        return nil unless cur
        redis.hgetall(redis_key_last(cur)) || redis.hgetall(redis_key_nextlast(cur))
      end

      def banned_ips
        threshold = config[:user_lock_threshold]
        redis.keys('isu4:ip:*').select do |key|
          failures = redis.get(key).to_i
          threshold <= failures
        end.map do |key|
          key[8..-1]
        end
      end

      def locked_users
        threshold = config[:user_lock_threshold]
        redis.keys('isu4:user:*').select do |key|
          failures = redis.get(key).to_i
          threshold <= failures
        end.map do |key|
          key[10..-1]
        end
      end
    end

    get '/' do
      erb :index, layout: :base
    end

    post '/login' do
      user, err = attempt_login(params[:login], params[:password])
      if user
        session[:user_id] = user['id']
        redirect '/mypage'
      else
        case err
        when :locked
          flash[:notice] = "This account is locked."
        when :banned
          flash[:notice] = "You're banned."
        else
          flash[:notice] = "Wrong username or password"
        end
        redirect '/'
      end
    end

    get '/mypage' do
      unless current_user
        flash[:notice] = "You must be logged in"
        redirect '/'
      end
      erb :mypage, layout: :base
    end

    get '/report' do
      content_type :json
      {
        banned_ips: banned_ips,
        locked_users: locked_users,
      }.to_json
    end
  end
end
