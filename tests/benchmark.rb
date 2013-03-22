require File.expand_path('test_helper', File.dirname(__FILE__))
require 'minitest/benchmark'

include Rack::Test::Methods

def app
  Nesta::App
end

describe "benchmark" do

  puts "="*80
  puts "Ruby Version: #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} (#{RUBY_PLATFORM})"
  puts "="*80

  bench_range { bench_exp 1, 10_000 }

  bench_performance_linear "main", 0.9999 do |n|
    n.times do
      get '/'
      assert last_response.body
    end
  end

  bench_performance_linear "sub", 0.9999 do |n|
    n.times do
      get '/about'
      assert last_response.body
    end
  end
end
