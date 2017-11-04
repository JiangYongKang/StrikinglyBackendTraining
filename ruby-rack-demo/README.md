# Ruby rack
Ruby Rack 是一个接口，用于 Ruby Web 应用与应用服务器之间的交互，如图所示：
最左边的 User Agent 就是浏览器等客户端，它发起 HTTP 请求；中间的 Rack Serve r是应用服务器，它响应 HTTP 请求，并调用我们的 Rack 应用；最右边是我们的应用程序——它可能是一个 Rails 或者 Sinatra 应用。Rack 服务器和 Rack 应用程序之间通过 Rack 接口交互。
