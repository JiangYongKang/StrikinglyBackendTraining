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
