# 使用中间件的 rack 程序
require 'rack'

class Decorator
  def initialize(application)
    @application = application
  end
  # 必须提供一个 call 方法
  def call(env)
    status, headers, body = @application.call(env)
    new_body = 'From middleware input. '
    body.each { |s| new_body << s }
    headers['Content-Length'] = new_body.bytesize.to_s
    [status, headers, [new_body]]
  end
end

application = Proc.new do |env|
  ['200', { 'Content-Type' => 'text/html' }, ['Hello, Rack!']]
end

Rack::Handler::WEBrick.run(Decorator.new(application), :Port => 8080, :Host => 'localhost')