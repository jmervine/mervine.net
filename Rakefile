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

# short cut when only a single environment
task :deploy do
  Rake::Task['prod:deploy'].invoke
end

namespace :prod do
  desc "deploy to production"
  task :deploy do
    system("ssh #{PRODUCTION_HOST} 'set -x; cd ~/www.rubyops.net && git pull && bundle'")
  end

  desc "restart production" 
  task :restart do
    system("ssh #{PRODUCTION_HOST} 'set -x; cd ~/www.rubyops.net && RACK_ENV=#{ENV['RACK_ENV']} bundle exec rake unicorn:restart --trace'")
  end

  task :warmup do
    system("ssh #{PRODUCTION_HOST} 'set -x; WARMUP_HOST=#{PRODUCTION_HOST} cd ~/www.rubyops.net && bundle exec rake cache:empty cache:warmup --trace'")
  end
end

namespace :cache do
  desc "empty diskcached cache"
  task :empty do
    %x{ cd #{APP_ROOT} && rm $( cat ./config/config.yml | grep diskcached_dir | awk '{ print $2 }' )/*.cache }
  end
  desc "warmup diskcached cache"
  task :warmup do
    ENV['WARMUP_HOST'] ||= "localhost"
    %x{
      set -x
      for url in $(curl #{ENV['WARMUP_HOST']}/sitemap.xml | grep "<loc>http" | sed "s/    <loc>//" | sed "s/<\\/loc>//" | sort -u ); do
        curl $url
      done
    } 
  end
end

