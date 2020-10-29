#!/usr/bin/ruby

require 'sinatra'
require 'simplehttp'
require 'json'
require 'ostruct'
require 'awesome_print'
require 'open-uri'
require 'twitter'
require 'haml'

before do
@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "YOUR_CONSUMER_KEY"
  config.consumer_secret     = "YOUR_CONSUMER_SECRET"
  config.access_token        = "YOUR_ACCESS_TOKEN"
  config.access_token_secret = "YOUR_ACCESS_SECRET"
end
end


get '/haml' do 
    
# accesses streams, which require special authentication to twitter
# client.sample do |object|
#   puts object.text if object.is_a?(Twitter::Tweet)
# end

# fetches timeline of authenticated user
 @client.home_timeline.each do | tweet |
     puts tweet.text
 end

haml :index 

end 

get '/erb' do 
    

# no recent proposals!
 @client.search("to:justinbieber marry me", result_type: "recent").take(3).collect do |tweet|
   "#{tweet.user.screen_name}: #{tweet.text}"
 end

erb :index 

end 
