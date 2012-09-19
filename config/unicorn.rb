timeout 30
stderr_path "log/unicorn_err.log"
stdout_path "log/unicorn_out.log"
listen 8080

case ENV['RACK_ENV'] 
when 'production'
  worker_processes 8
when 'staging'
  worker_processes 4
else
  worker_processes 2
end
