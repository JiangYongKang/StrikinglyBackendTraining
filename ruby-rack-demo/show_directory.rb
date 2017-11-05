# 把 home 目录下的全部文件在浏览器中显示
require "rack"

Rack::Handler::WEBrick.run Rack::Directory.new '~/'
