# 在使用多个中间件的时候，Rack::builder 可以管理中间件，防止混乱
require "rack"

rack = Rack::Builder.new do
  use Rack::ContentLength
  use Rack::ShowExceptions
  run lambda { |env| [200, {"Content-Type"=>"text/html"}, ["Hello, Rack!"]] }
end

Rack::Handler::WEBrick.run(rack.to_app, :Port => 8080, :Host => 'localhost')
