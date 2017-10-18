# Puma web server
* Puma 是一个简单、高并发的 HTTP 1.1 服务器。
* 它是基于线程的，并且一个线程运行一次 Ruby 代码。
* Rails 内置的默认 web server。
* 项目地址：[https://github.com/puma/puma](https://github.com/puma/puma)

## 配置 Puma
默认的 `rails` 项目中，`config/puma.rb` 就是它的配置文件。而我们平时使用 `rails s` 启动项目时，使用的也正是这份配置文件。
完整的配置项已经写在项目里面了，这里：
