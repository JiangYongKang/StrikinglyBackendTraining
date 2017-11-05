# 通过 rackup rackup_start.rb 启动
require 'rack'

application = proc do |env|
  ['200', { 'Content-Type' => 'text/html' }, ['Hello, Rack!']]
end

Rack::Handler::WEBrick.run(application, :Port => 8080, :Host => 'localhost')
