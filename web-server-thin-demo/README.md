# Thin web server
Thin 是一个轻量级的 web 服务器，他的作用类似于 Java 中的 Tomcat、Jboss。不同的是它只是一个 web 服务器，而后者属于应用服务器。
更加详细的资料：[https://github.com/macournoyer/thin](https://github.com/macournoyer/thin)

### 在 Rails 中使用 Thin
在 Gemfile 中添加如下代码，并执行 `bundle install`
```ruby
gem 'thin'
gem 'faye-websocket'  # 如果你准备使用 Action cable，必须添加这个 Gem
```
```zsh
$ bundle install
```

### 启动方式
```ruby
$ rails s thin
=> Booting Thin  # 从这里就可以看到，我们使用的是 Thin web server 进行启动的
=> Rails 5.1.4 application starting in development on http://localhost:3000
=> Run `rails server -h` for more startup options
Thin web server (v1.7.2 codename Bachmanity)
Maximum connections set to 1024
Listening on localhost:3000, CTRL+C to stop
```
访问 [localhost:3000](localhost:3000) 就可以看到熟悉的 Rails 欢迎界面。
虽然 Rails 中默认有一个服务器 `puma`，但是在启动方面，Rails 做的无比灵活（和 Java 相比）。
我们可以使用：`rails s thin` 或者 `rails s puma` 来选择自己需要的服务器进行启动。
```ruby
$ rails s puma
=> Booting Puma
=> Rails 5.1.4 application starting in development
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.10.0 (ruby 2.4.1-p111), codename: Russells Teapot
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```
当然，我们也可以将 `gem 'puma'` 这行代码注释掉，然后是需要输入 `rails s`，那么默认启动的就是 `Thin`。
当我们把 `gem 'puma'` 和 `gem 'thin'` 全部都注释掉了，`rails s` 命令依然可以启动整个项目。
但是启动的是 `WEBrick` 这个服务器。启动过程如下：
```ruby
$ rails s
=> Booting WEBrick
=> Rails 5.1.4 application starting in development on http://localhost:3000
=> Run `rails server -h` for more startup options
[2017-10-18 13:26:07] INFO  WEBrick 1.3.1
[2017-10-18 13:26:07] INFO  ruby 2.4.1 (2017-03-22) [x86_64-darwin16]
[2017-10-18 13:26:07] INFO  WEBrick::HTTPServer#start: pid=94464 port=3000
```
顺序：puma || thin >> WEBrick

### 使用 `thin` 命令启动
当你不想使用 `rails s` 这个命令进行启动的时候，也可以通过 `thin strat` 命令来启动你的项目。
```zsh
$ thin start   # 启动
$ thin stop    # 停止
$ thin restart # 重启
```

### 使用配置文件进行启动
Thin 有一个非常好用的功能，就是可以自动生成有默认值的配置文件（妈妈再也不用担心我 copy 到脏的配置文件了）
```ruby
$ thin config -C config/thin.yml # 这个命令将会在项目的 config 文件夹下生成 thin.yml
```
这就是生成的文件内容，配置项非常清晰易懂。
需要注意的是 `log`、`pid` 这两个选项，最好不要自己去写，容易写错。
```yml
---
chdir: "/Users/vincent/project/ruby-self-training-demos/web-server-thin-demo"
environment: development
address: 0.0.0.0
port: 3000
timeout: 30
log: "/Users/vincent/project/ruby-self-training-demos/web-server-thin-demo/log/thin.log"
pid: tmp/pids/thin.pid
max_conns: 1024
max_persistent_conns: 100
require: []
wait: 30
threadpool_size: 20
daemonize: true
```
好了，我们不需要改变任何配置文件的内容，直接启动：
```zsh
$ thin start -C config/thin.yml
```
这次的启动是在后台进行的，终端不会打印启动信息。启动日志可以在 `log/thin.log` 查看，进程可以在 `tmp/pids/thin.pid` 中查看。
停止服务器就只能在终端中 `kill cat tmp/pids/thin.pid` 了。
