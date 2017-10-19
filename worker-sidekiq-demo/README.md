# Worker sidekiq
[Sidekiq](http://sidekiq.org/) 用于处理大量的、耗时的后台作业任务。可以免费使用，但是部分功能收费。
GitHub 地址: [https://github.com/mperham/sidekiq](https://github.com/mperham/sidekiq)

## 在 Rails 项目中使用 Sidekiq
在 Gemfile 中添加代码
```ruby
gem 'sidekiq' # sidekiq
gem 'redis'   # sidekiq redis
gem 'redis-namespace' # sidekiq redis
gem 'rainbow' # 终端色彩显示，不是必须的
```
在 `config/secrets.yml` 中添加 `Redis` 的配置
```yml
redis: &redis
  redis_server: 'localhost'
  redis_port: 6379
  redis_db_num: 1
  redis_namespace: 'worker_sidekiq'

development:
  <<: *redis
test:
  <<: *redis
```
在 `config/initializers` 下新建 `sidekiq.rb` 文件，并加入如下代码，初始化 `Redis` 和 `Sidekiq config`
```ruby
redis_server = Rails.application.secrets.redis_server
redis_port = Rails.application.secrets.redis_port
redis_db_num = Rails.application.secrets.redis_db_num
redis_namespace = Rails.application.secrets.redis_namespace

# TODO: Sidekiq 社区不推荐使用命名空间
Sidekiq.configure_server do |config|
  # config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace }
  config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }
end

Sidekiq.configure_client do |config|
  # config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}", namespace: redis_namespace }
  config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }
end
```
在 `config` 目录下新建 `sidekiq.yml` 文件，作为 `sidekiq` 的配置文件
```yml
:concurrency: 5
:pidfile: /Users/vincent/project/ruby-self-training-demos/worker-sidekiq-demo/tmp/pids/sidekiq.pid

:queues:
    - default
    - queue_a
    - queue_b
    - queue_c

development:
  :concurrency: 5
staging:
  :concurrency: 10
production:
  :concurrency: 20
```
通过生成器来生成基本的 `worker` 代码
```ruby
$ rails g sidekiq:worker Hard
Running via Spring preloader in process 3710
      create  app/workers/hard_worker.rb
      create  test/workers/hard_worker_test.rb
```
修改 `app/workers/hard_worker.rb` 代码，添加一个打印语句
```ruby
class HardWorker
  include Sidekiq::Worker

  # TODO: 调用方式
  #       HardWorker.perform_async(100, 200, 300)
  def perform(*args)
    puts "#{DateTime.now.to_s(:db)} ".color(:red) + "HardWorker#perform #{args.to_s}".color(:yellow)
  end
end
```
启动 `Sidekiq`，`--config` 选项可以指定配置文件启动
```log
$ bundle exec sidekiq --config config/sidekiq.yml
2017-10-19T06:41:54.462Z 9774 TID-oursd3qv8 INFO: Booting Sidekiq 5.0.5 with redis options {:url=>"redis://localhost:6379/1", :id=>"Sidekiq-server-PID-9774"}


         m,
         `$b
    .ss,  $$:         .,d$
    `$$P,d$P'    .,md$P"'
     ,$$$$$bmmd$$$P^'
   .d$$$$$$$$$$P'
   $$^' `"^$$$'       ____  _     _      _    _
   $:     ,$$:       / ___|(_) __| | ___| | _(_) __ _
   `b     :$$        \___ \| |/ _` |/ _ \ |/ / |/ _` |
          $$:         ___) | | (_| |  __/   <| | (_| |
          $$         |____/|_|\__,_|\___|_|\_\_|\__, |
        .d$$                                       |_|

2017-10-19T06:41:54.573Z 9774 TID-oursd3qv8 INFO: Running in ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin16]
2017-10-19T06:41:54.573Z 9774 TID-oursd3qv8 INFO: See LICENSE and the LGPL-3.0 for licensing details.
2017-10-19T06:41:54.573Z 9774 TID-oursd3qv8 INFO: Upgrade to Sidekiq Pro for more features and support: http://sidekiq.org
2017-10-19T06:41:54.605Z 9774 TID-oursd3qv8 INFO: Starting processing, hit Ctrl-C to stop
```

开启一个新的终端，在 `rails c` 下输入 `HardWorker.perform_async(100, 200, 300)`

```ruby
$ rails c
Running via Spring preloader in process 10433
Loading development environment (Rails 5.1.4)
irb(main):001:0> HardWorker.perform_async(100, 200, 300)
=> "719569316a29897930c63545"
```
查看 `sidekiq` 终端下的日志
```ruby
2017-10-19T06:52:25.305Z 10444 TID-ov4cg11m4 HardWorker JID-719569316a29897930c63545 INFO: start
2017-10-19 14:52:25 HardWorker#perform [100, 200, 300]
2017-10-19T06:52:25.306Z 10444 TID-ov4cg11m4 HardWorker JID-719569316a29897930c63545 INFO: done: 0.001 sec
```

## Active Job 和 Sidekiq
通过生成器生成一个 Job
```ruby
$ rails generate job rest
Running via Spring preloader in process 10578
      invoke  test_unit
      create    test/jobs/rest_job_test.rb
      create  app/jobs/rest_job.rb
```
在 `config/application.rb` 中添加：
```ruby
config.active_job.queue_adapter = :sidekiq
```
在 `rails c` 中添加一个任务：
```ruby
$ rails c
Running via Spring preloader in process 10658
Loading development environment (Rails 5.1.4)
irb(main):001:0> RestJob.set(wait: 10.second).perform_later(100, 200, 300) # 设置为 10 秒钟后执行
Enqueued RestJob (Job ID: 2ae1c108-ef94-4b89-af0c-8808631cd8bf) to Sidekiq(default) at 2017-10-19 06:59:30 UTC with arguments: 100, 200, 300
=> #<RestJob:0x007ffa2c15d780 @arguments=[100, 200, 300], @job_id="2ae1c108-ef94-4b89-af0c-8808631cd8bf", @queue_name="default", @priority=nil, @executions=0, @scheduled_at=1508396370.797518, @provider_job_id="aa8bdf6140f698d3051c7711">
```
十秒钟后可以看到以下日志输出：
```ruby
2017-10-19T06:59:36.815Z 10444 TID-ov4cg11m4 RestJob JID-aa8bdf6140f698d3051c7711 INFO: start
2017-10-19 14:59:36 RestJob#perform [100, 200, 300]
2017-10-19T06:59:36.841Z 10444 TID-ov4cg11m4 RestJob JID-aa8bdf6140f698d3051c7711 INFO: done: 0.027 sec
```

## 可视化界面
在 `Gemfile` 中添加：
```ruby
gem 'sinatra'
```
在 `config/routes.rb` 中添加：
```ruby
require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
```
启动项目，访问: [http://localhost:3000/sidekiq](http://localhost:3000/sidekiq)
