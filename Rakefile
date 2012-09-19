require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test)

begin
  require 'vlad'
  # Set :app to :passenger if you're using Phusion Passenger.
  require 'vlad/git'
  require 'vlad/unicorn'
  require 'vlad/nginx'
  Vlad.load(:scm => :git, :app => :unicorn, :web => :nginx)
rescue LoadError => e
  puts e.inspect
end

