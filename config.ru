require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'nesta/env'
Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

require 'nesta/app'

begin
  require 'newrelic_rpm'
  NewRelic::Agent.after_fork(:force_reconnect => true)
rescue LoadError
end

unless ENV['RACK_ENV'] == "development"
  require 'rack/hard/copy'
  use Rack::Hard::Copy, :store   => "./public/static",
                        :ignores => [ "search", "js", "png", "gif" ],
                        :headers => false,
                        :timeout => false
end

use Rack::Codehighlighter, :ultraviolet, :theme => "twilight", :lines => false, :markdown => true,
    :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => false

run Nesta::App
