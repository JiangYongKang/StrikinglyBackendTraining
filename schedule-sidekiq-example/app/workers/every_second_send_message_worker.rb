class EverySecondSendMessageWorker

  include Sidekiq::Worker
  sidekiq_options queue: :schedule, backtrace: true, retry: false

  # 无需显示调用，sidekiq 运行后会自动执行
  # 传入参数和执行周期在 config/sidekiq_schedule.yml 中配置
  def perform(*args)
    logger.info 'every second execution...'
  end
end
