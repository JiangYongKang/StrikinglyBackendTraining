require 'grape'

class Application < Grape::API
  format :json
  prefix :api
  get '/' do
    { hello: 'grape' }
  end
end
