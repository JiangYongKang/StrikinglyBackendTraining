# Puma web server
* Puma 是一个简单、高并发的 HTTP 1.1 服务器。
* 它是基于线程的，并且一个线程运行一次 Ruby 代码。
* Rails 内置的默认 web server。
* 项目地址：[https://github.com/puma/puma](https://github.com/puma/puma)

## 配置 Puma
默认的 `rails` 项目中，`config/puma.rb` 就是它的配置文件。而我们平时使用 `rails s` 启动项目时，使用的也正是这份配置文件。
完整的配置项已经写在项目里面了，这里是[完整的配置](https://github.com/JiangYongKang/ruby-self-training-demos/blob/master/web-server-puma-demo/config/puma.rb)。

`puma.rb` 它虽然作为 `Puma` 的配置文件，但是它的本质还是 `ruby` 文件。也就意味着我们可以在里面写 `ruby` 代码。
例如我们在它的第一行写上如下代码，并通过 `rails s` 启动项目：
```ruby
# config/puma.rb
puts "Read the configuration file ..."

$ rails s
=> Booting Puma
=> Rails 5.1.4 application starting in development
=> Run `rails server -h` for more startup options
Read the configuration file ... # 这里能看到输出的内容
Puma starting in single mode...
* Version 3.10.0 (ruby 2.4.1-p111), codename: Russells Teapot
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```

设定 `threads` 和 `workers`。Puma 是一个多线程高并发的 web server，所以它自然有线程池的相关配置。其中 `threads` 是用来配置最大最小线程数量的，`workers` 是用来配置进程数量的。
`worker` 是有守护线程保护的，即使 `kill` 了它，它也会自动再次创建 `worker` 的。
添加一下配置项，并启动项目，观察启动日志：
```ruby
# config/puma.rb
threads 5, 10
workers 2

$ rails s
=> Booting Puma
=> Rails 5.1.4 application starting in development
=> Run `rails server -h` for more startup options
[99051] Puma starting in cluster mode...
[99051] * Version 3.10.0 (ruby 2.4.1-p111), codename: Russells Teapot
[99051] * Min threads: 5, max threads: 10 # 这里能看到最小、最大线程数量
[99051] * Environment: development
[99051] * Process workers: 2
[99051] * Phased restart available
[99051] * Listening on tcp://0.0.0.0:3000
[99051] Use Ctrl-C to stop
[99051] - Worker 0 (pid: 99075) booted, phase: 0 # 这两个分别是两个 worker
[99051] - Worker 1 (pid: 99076) booted, phase: 0
```

剩下的一些设置不列举，`config/puma.rb` 文件中有详细的说明和注释。

|配置项|参数|默认值|说明|示例代码|
|:--|:--|:--|:--|:--|
|port|number|3000|启动的端口号|port 3000|
|environment|string|development|启动环境|environment 'development'|
|on_restart|block|--|重启服务器执行的代码块|on_restart { puts "on restart..." }|
|before_fork|block|--|预加载之前执行|before_fork { puts "before fork..." }|
|on_worker_boot|block|--|创建 worker 之前执行|on_worker_boot { puts "on worker boot..." }|
|on_worker_shutdown|block|--|结束 worker 之前执行|on_worker_shutdown { puts "on worker shutdown..." }|
|on_worker_fork|block|--|worker 之前执行|on_worker_fork { puts "on worker fork..." }|
|after_worker_fork|block|--|worker 之后执行|after_worker_fork { puts "after worker fork..." }|
