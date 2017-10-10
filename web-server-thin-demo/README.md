### Thin With Rails
[GitHub 地址] (https://github.com/macournoyer/thin)
[官网] (http://code.macournoyer.com/thin/)

### 安装
在 Gemfile 中加入
```ruby
gem 'thin'
gem 'faye-websocket'
```
```zsh
$ bundle install
```
项目根目录下创建 `config.ru`
```ruby
# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
run Rails.application
```
`config` 目录下添加 `thin.yml` 文件
```yml
---
chdir: You application path ...
environment: development
address: 0.0.0.0
port: 3000
timeout: 30
log: "You application path ... /log/thin.log"
pid: "You application path ... /pids/thin.pid"
max_conns: 1024
max_persistent_conns: 100
require: []
wait: 30
threadpool_size: 20
daemonize: true
```

### 启动命令
```zsh
$ thin start -C config/thin.yml
```
生成的日志不会再控制台中，在 `log/thin.log` 和 `log/development.log`，进程 ID 在 `pids/thin.pid` 文件中
访问: [localhost:3000] (localhost:3000)

### 停止服务
```zsh
$ kill cat pids/thin.pid
```
