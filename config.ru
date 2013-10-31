#ENV['RACK_ENV'] = "development"

require 'rubygems'
require 'bundler'
Bundler.require

require './parlamentoapi'
run Sinatra::Application
