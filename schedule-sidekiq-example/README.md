# Schedule sidekiq example

版本
```console
$ ruby -v
ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin17]
$ rails -v
Rails 5.2.0
$ sidekiq -V
Sidekiq 5.1.3
```

安装依赖
```console
$ bundle install
```

启动 rails
```console
$ rails s
```

启动 sidekiq
```console
$ sidekiq -C config/sidekiq.yml
```

观察 sidekiq 日志
```console
$ tail -f log/sidekiq.log
```

创建异步作业
```console
$ rails c
Running via Spring preloader in process 34778
Loading development environment (Rails 5.2.0)
irb(main):001:0>AsyncSendMessageWorker.perform_async
```

如何添加自己的异步任务？
```console
$ rails generate sidekiq:worker my_task
Running via Spring preloader in process 30574
      create  app/workers/my_task_worker.rb
      create  test/workers/my_task_worker_test.rb
```
