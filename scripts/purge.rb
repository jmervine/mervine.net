#!/usr/bin/env ruby
require 'netdnarws'
require 'yaml'

config = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), '..', '..', 'maxcdn.yml'))

# file: maxcdn.yml
# place one level above git repo
#
# alias:  <ALIAS>
# key:    <KEY>
# secret: <SECRET>
# zone:   <ZONE_ID>
# files:  # optional w/o purges whole zone
# - /file/1
# - /file/2

api = NetDNARWS::NetDNA.new(config['alias'], config['key'], config['secret'])
if config['files']
  api.purge(config['zone'], config['files'])
else
  api.purge(config['zone'])
end
