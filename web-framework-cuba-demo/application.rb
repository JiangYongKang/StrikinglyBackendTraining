require 'cuba'
require 'cuba/safe'

Cuba.use Rack::Session::Cookie, :secret => '__a_very_long_string__'
Cuba.plugin Cuba::Safe

Cuba.define do
  on get do
    on "/" do
      res.write "hello cuba!"
    end

    on root do
      res.redirect "/"
    end
  end
end
