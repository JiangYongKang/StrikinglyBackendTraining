# Worker resque demo
用于创建后台作业，将这些作业放置在多个队列中，稍后再处理。

## 启动演示
```ruby
$ rails s
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
```ruby
$ rails c
Running via Spring preloader in process 20078
Loading development environment (Rails 5.1.4)
irb(main):001:0> CleanUpJob.perform_later
Enqueued CleanUpJob (Job ID: e3b712fb-c4a1-491a-9485-2553e75bafd8) to Resque(default)
=> #<CleanUpJob:0x007fef8d2461f0 @arguments=[], @job_id="e3b712fb-c4a1-491a-9485-2553e75bafd8", @queue_name="default", @priority=nil, @executions=0>
```
在三个终端下打开，然后观察这个终端的输出
```ruby
$ QUEUE=* rake resque:work # "*" 代表全部的队列名称，如果想要启动指定的队列，只需要指定相应的队列名就好
Start executing the cleanup task ...
```

## 如何配置？
在 `config/application.rb` 中插入一行代码，指定使用的队列:
```ruby
config.active_job.queue_adapter = :resque
```
在 `Rakefile` 中引入 `resque/tasks`
```ruby
require 'resque/tasks'
```
如果是 rails 5.x 以上版本，还可以在加入一行代码：
```ruby
task 'resque:setup' => :environment
```
任意创建一个 Job:
```ruby
$ rails generate job CleanUp
```
在 `perform` 方法中加入一个打印语句：
```ruby
def perform(*args)
  puts "Start executing the cleanup task ..."
end
```
