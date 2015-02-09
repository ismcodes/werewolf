require './werewolf'
run Sinatra::Application

ENV['RACK_ENV'] ||= 'development'
