# 使用 map 方法，可以创建出带路由的中间件
require "rack"

rack = Rack::Builder.new do
  # localhost:8080
  map '/' do
    run lambda { |env| [200, {"Content-Type"=>"text/html"}, ["Hello, Rack!"]] }
  end

  # localhost:8080/bar
  map '/bar' do
    run lambda { |env| [200, {"Content-Type"=>"text/html"}, ["Routes bar"]] }
  end

  # localhost:8080/foo
  map '/foo' do
    run lambda { |env| [200, {"Content-Type"=>"text/html"}, ["Routes foo"]] }
  end
end

Rack::Handler::WEBrick.run(rack.to_app, :Port => 8080, :Host => 'localhost')
