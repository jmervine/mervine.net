timeout 30
preload_app true
stderr_path "log/unicorn_err.log"
stdout_path "log/unicorn_out.log"

case ENV['RACK_ENV']
when 'production'
  listen "/home/jmervine/www.rubyops.net/sockets/unicorn.sock", :backlog => 64
  worker_processes 4
when 'staging'
  worker_processes 4
  listen 9001
else
  worker_processes 2
  listen 8080
end

