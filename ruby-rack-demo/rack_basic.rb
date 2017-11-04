# 基本的 rack 程序
require 'rack'

application = proc do |env|
  ['200', { 'Content-Type' => 'text/html' }, ['Hello, Rack!']]
end

Rack::Handler::WEBrick.run(application, :Port => 8080, :Host => 'localhost')
