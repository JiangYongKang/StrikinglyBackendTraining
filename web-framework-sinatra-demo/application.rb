require 'sinatra'

get '/' do
  @message = 'Hello sinatra'
  erb :default_index
end
