require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test)

namespace :unicorn do
  ENV['RACK_ENV'] ||= "production"
  APP_ROOT = File.dirname(__FILE__)
  CFG_FILE = File.join( APP_ROOT, "config", "unicorn.rb" )
  task :start do
    system("cd #{APP_ROOT} && RACK_ENV=#{ENV['RACK_ENV']} bundle exec unicorn -D -c #{CFG_FILE}")
  end
  task :stop do
    system("pkill -QUIT -f \"#{CFG_FILE}\"")
  end
  task :restart do
    Rake::Task['unicorn:stop'].invoke
    sleep 5
    Rake::Task['unicorn:start'].invoke
  end
end

