worker_processes 10
preload_app true
listen "/tmp/unicorn.sock"

stdout_path File::NULL unless ENV['ISUDEBUG']
stderr_path File::NULL unless ENV['ISUDEBUG']
