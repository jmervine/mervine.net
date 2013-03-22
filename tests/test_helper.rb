ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'

require 'nesta/env'
Nesta::Env.root = ::File.expand_path('..', ::File.dirname(__FILE__))

require 'nesta/app'

