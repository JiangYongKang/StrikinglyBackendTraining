# 读取 redis 配置文件
redis = Rails.application.config_for(:redis).symbolize_keys!
redis_server = redis[:redis_server]
redis_port   = redis[:redis_port]
redis_db_num = redis[:redis_db_num]

# 设置 sidekiq cron 每秒钟更新一次
Sidekiq.options[:poll_interval]                   = 1
Sidekiq.options[:poll_interval_average]           = 1

# 设置 sidekiq 数据源
Sidekiq.configure_server do |config|

  # 配置数据库连接
  config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }

  # 设置 sidekiq 每秒钟都会检查一次作业（默认每5秒检查一次）
  config.average_scheduled_poll_interval = 1

  # 从配置文件中读取定时任务
  schedule_file = 'config/sidekiq_schedule.yml'
  if File.exists?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_server}:#{redis_port}/#{redis_db_num}" }
end
