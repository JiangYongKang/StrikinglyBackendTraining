require 'sinatra'

# TODO: matches Get localhost:4567
get '/' do
  'Hello sinatra'
end

# TODO: matches Get localhost:4567/vincent
get '/:name' do
  params['name']
end

# TODO: matches Get localhost:4567/say/hello/to/world
get '/say/*/to/*' do
  params['splat'].to_s
end

# TODO: matches Get localhost:4567/download/rubydoc.pdf
get '/download/*.*' do
  params['splat'].to_s
end
