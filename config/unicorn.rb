timeout 30
stderr_path "log/unicorn_err.log"
stdout_path "log/unicorn_out.log"
pid         "log/unicorn.pid"
worker_processes 2

case ENV['RACK_ENV']
when 'production'
  listen "/home/jmervine/mervine.net/sockets/unicorn.sock", :backlog => 64
when 'staging'
  listen 9001
else
  listen 8080
end

