rails_root = `pwd`.gsub("\n", "")

worker_processes 2
preload_app true
timeout 30
working_directory rails_root

listen "#{rails_root}/tmp/sock/unicorn.sock", :backlog => 64, :tcp_nopush => false
pid "#{rails_root}/tmp/pids/unicorn.pid"

stderr_path "#{rails_root}/log/unicorn.stderr.log"
stdout_path "#{rails_root}/log/unicorn.stdout.log"
