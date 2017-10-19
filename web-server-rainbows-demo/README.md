# Rainrows web server
* [Rainrows](https://github.com/rosylilly/rainbows) 和 [Unicorn](https://github.com/defunkt/unicorn) 是同一个作者开发的。
* Rainrows 和 Unicorn 的配置方式、启动方式、启动参数完全相同。
* Rainrows 是多线程服务器、Unicorn 是多进程服务器。
* 在多核服务器上需要开启多个 Rainrows 进程，服务器有多少个核，就开启多少个 worker 进程。
* 每个 worker 又可以开启多个线程。
* 能够同时处理的 IO 并发请求等于 workers * threads

### 参考资料
* [https://bogomips.org/rainbows/](https://bogomips.org/rainbows/)
* [https://ruby-china.org/topics/10832](https://ruby-china.org/topics/10832)
* [https://github.com/robbin/robbin_site/blob/master/config/rainbows.rb](https://github.com/robbin/robbin_site/blob/master/config/rainbows.rb)
