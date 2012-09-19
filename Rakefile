require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test)

PRODUCTION_HOST ||= "www.rubyops.net"
ENV['RACK_ENV'] ||= "production"

namespace :unicorn do
  APP_ROOT = File.dirname(__FILE__)
  CFG_FILE = File.join( APP_ROOT, "config", "unicorn.rb" )

  desc "start unicorn"
  task :start do
    system("cd #{APP_ROOT} && RACK_ENV=#{ENV['RACK_ENV']} bundle exec unicorn -D -c #{CFG_FILE}")
  end

  desc "stop unicorn"
  task :stop do
    system("pkill -QUIT -f \"#{CFG_FILE}\"")
  end

  desc "restart unicorn"
  task :restart do
    Rake::Task['unicorn:stop'].invoke
    sleep 5
    Rake::Task['unicorn:start'].invoke
  end
end

namespace :production do
  desc "deploy to production"
  task :deploy do
    system("ssh #{PRODUCTION_HOST} 'set -x; cd ~/www.rubyops.net && git pull && bundle'")
  end

  desc "restart production" 
  task :restart do
    system("ssh #{PRODUCTION_HOST} 'set -x; cd ~/www.rubyops.net && RACK_ENV=#{ENV['RACK_ENV']} bundle exec rake unicorn:restart --trace'")
  end
end
