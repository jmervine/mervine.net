require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require 'nesta/env'
Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

require 'nesta/app'

require 'rack/host_redirect'

use Rack::HostRedirect, {
  'mervine-net.herokuapp.com' => 'www.mervine.net',
  'joshua.mervine.net' => {host: 'www.mervine.net', path: '/resume', query: nil},
  'josh.mervine.net' => {host: 'www.mervine.net', path: '/resume', query: nil}
}

if ENV['RACK_ENV'] == "production"
  begin
    require 'newrelic_rpm'
    NewRelic::Agent.after_fork(:force_reconnect => true)
  rescue LoadError
  end


  require 'rack/hard/copy'
  use Rack::Hard::Copy, :store   => "./_static",
                        :ignores => [ "search", "js", "png", "gif" ],
                        :headers => false,
                        :timeout => false


#  require 'htmlcompressor'
#  use HtmlCompressor::Rack, {
#    :enabled => true,
#    :remove_multi_spaces => true,
#    :remove_comments => true,
#    :remove_intertag_spaces => false,
#    :remove_quotes => true,
#    :compress_css => true,
#    :compress_javascript => true,
#    :simple_doctype => false,
#    :remove_script_attributes => true,
#    :remove_style_attributes => true,
#    :remove_link_attributes => true,
#    :remove_form_attributes => false,
#    :remove_input_attributes => true,
#    :remove_javascript_protocol => true,
#    :remove_http_protocol => true,
#    :remove_https_protocol => false,
#    :preserve_line_breaks => false,
#    :simple_boolean_attributes => true
#  }

end

use Rack::Codehighlighter, :ultraviolet, :theme => "twilight", :lines => false, :markdown => true,
  :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => false

run Nesta::App
