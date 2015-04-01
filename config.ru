require 'rubygems'
require 'bundler'

Bundler.require


require File.expand_path '../server.rb', __FILE__

run Rack::URLMap.new({
  "/" => Public,
  "/files" => Protected
})
