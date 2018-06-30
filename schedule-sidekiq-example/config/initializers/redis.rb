require 'redis'

# 读取 redis 配置文件
redis = Rails.application.config_for(:redis).symbolize_keys!
redis_server = redis[:redis_server]
redis_port   = redis[:redis_port]
redis_db_num = redis[:redis_db_num]

# 实例化全局对象 $redis
$redis = Redis.new(host: redis_server, port: redis_port, db: redis_db_num)
