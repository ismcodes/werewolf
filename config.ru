require './werewolf'
require 'twilio-ruby'
run Sinatra::Application
$client = Twilio::REST::Client.new ENV["account_sid"], ENV["auth_token"]
ENV['RACK_ENV'] ||= 'development'
