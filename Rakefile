require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, :test)

begin
  require 'vlad'
  # Set :app to :passenger if you're using Phusion Passenger.
  Vlad.load(:scm => :git, :app => :unicorn, :web => :nginx)
rescue LoadError
end

