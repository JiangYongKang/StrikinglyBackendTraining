# 添加 sidekiq 和 sidekiq cron 定时任务的控制台面板路由
require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
end
