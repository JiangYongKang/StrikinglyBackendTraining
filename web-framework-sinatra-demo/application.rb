require 'sinatra/base'

class Application < Sinatra::Application

  # TODO: matches Get localhost:4567
  get '/' do
    'Hello sinatra'
  end

  # TODO: matches Get localhost:4567/hello/vincent
  get '/hello/:name' do
    "Hello #{params['name']}"
  end

  # TODO: matches Get localhost:4567/say/hello/to/world
  get '/say/*/to/*' do
    params['splat'].to_s
  end

  # TODO: matches Get localhost:4567/download/rubydoc.pdf
  get '/download/*.*' do
    params['splat'].to_s
  end

  # TODO: matches Get localhost:4567/hello/vincent
  #                   localhost:4567/hello/world
  get %r{/hello/([\w]+)} do
    params['captures'].to_s
  end

  # TODO: matches Get localhost:4567/posts
  #                   localhost:4567/posts/json
  #                   localhost:4567/posts/xml
  get '/posts/:format?' do
    params['format'].to_s
  end

  # TODO: matches Get localhost:4567/posts?title=foo&author=bar
  get '/posts' do
    [params['title'], params['author']]
  end
end
