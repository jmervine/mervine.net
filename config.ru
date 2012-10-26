require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

begin
  if File.exists? "./config/newrelic.yml"
    require 'newrelic_rpm'
    NewRelic::Agent.after_fork(:force_reconnect => true)
  end
rescue LoadError
  # proceed without NewRelic
end

use Rack::ConditionalGet
use Rack::ETag

require 'nesta/env'
Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

#use Rack::Codehighlighter, :coderay,
      #:element => "pre>code", :markdown => true

#use Rack::Codehighlighter, :ultraviolet, :theme => "espresso_libre", :lines => false, :markdown => true,
use Rack::Codehighlighter, :ultraviolet, :theme => "twilight", :lines => false, :markdown => true,
    :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => false

require 'nesta/app'
run Nesta::App
