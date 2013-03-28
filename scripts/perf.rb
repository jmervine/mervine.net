#!/usr/bin/env ruby
require 'json'
require 'httperf'

server = ENV['HTTPERF_HOST']  || "localhost"
uri    = ENV['HTTPERF_URI']   || "/"
conns  = ENV['HTTPERF_CONNS'] || 10

httperf = HTTPerf.new( "num-conns" => conns, "uri" => uri, "rate" => 1, "verbose" => true, "parse" => true )

puts "Starting: #{httperf.command}"

file = "test-#{Time.now.strftime("%Y%jT%H%M%S")}"

result = httperf.run

File.open("#{file}.json", "w") do |f|
  f.print result.to_json
end

File.open("#{file}.txt", "w") do |f|
  [ :total_connections,
    :connection_rate_per_sec,
    :connection_time_min,
    :connection_time_avg,
    :connection_time_max,
    :errors_total,
    :connection_time_85_pct,
    :connection_time_95_pct,
    :connection_time_99_pct ].each do |k|

    title = k.to_s.gsub("_", " ").capitalize+":"

    f.printf "%-25s %s\n", title, result[k].to_s
    printf "%-25s %s\n",   title, result[k].to_s
  end
end

puts "Done!"
