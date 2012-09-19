require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

use Rack::ConditionalGet
use Rack::ETag

require 'nesta/env'
Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

#use Rack::Codehighlighter, :syntax, # :coderay,
  #:element => "pre>code", :markdown => true

require 'nesta/app'
run Nesta::App
