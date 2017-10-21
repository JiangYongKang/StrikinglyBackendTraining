# Web framework sinatra
至今为止，我见到的最轻量的 web 框架！！！没有之一！！！
你启动它只需要三行代码！！！

## 安装
可以直接通过 `gem` 安装
```ruby
$ gem install sinatra
```
或者在根目录下创建一个 `Gemfile`
```ruby
source 'https://rubygems.org'
gem 'sinatra'
```
然后运行 `bundle install`

## 编写代码
在根目录下创建一个 `application.rb`
```ruby
require 'sinatra'
get '/' do
  'hello sinatra'
end
```
就这三行代码就够了，一个简单的服务端就搭建好了！让我们来启动它！
```ruby
$ ruby application.rb
== Sinatra (v2.0.0) has taken the stage on 4567 for development with backup from Thin
Thin web server (v1.7.2 codename Bachmanity) # 可以看到是用 Thin
Maximum connections set to 1024  # 最大连接数
Listening on localhost:4567, CTRL+C to stop # 监听端口
```
访问 [localhost:4567](localhost:4567)

[GitHub](https://github.com/sinatra/sinatra) [官方文档](http://www.sinatrarb.com/intro-zh.html)
