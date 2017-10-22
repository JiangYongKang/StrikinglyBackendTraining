# Ruby rack
Ruby Rack是一个接口，用于Ruby Web应用与应用服务器之间的交互，如图所示：
最左边的User Agent就是浏览器等客户端，它发起HTTP请求；中间的Rack Server是应用服务器2，它响应HTTP请求，并调用我们的Rack应用；最右边是我们的应用程序——它可能是一个Rails或者Sinatra应用。Rack服务器和Rack应用程序之间通过Rack接口交互。
