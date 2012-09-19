require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test)

namespace :unicorn do
  ENV['RACK_ENV'] ||= "production"
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

desc "deploy to production"
task :deploy do
  system("ssh www.rubyops.net 'set -x; cd ~/www.rubyops.net && git pull && bundle'")
end
