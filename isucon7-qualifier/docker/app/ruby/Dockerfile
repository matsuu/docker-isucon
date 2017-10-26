FROM ruby:2.4.2

ARG GIT_URL=https://github.com/isucon/isucon7-qualify.git

RUN git clone $GIT_URL /home/isucon/isubata
WORKDIR /home/isucon/isubata/webapp/ruby
RUN bundle install --path vendor/bundle

EXPOSE 5000

ENTRYPOINT ["bundle", "exec", "puma", "-p", "5000"]
CMD ["-t", "10"]
