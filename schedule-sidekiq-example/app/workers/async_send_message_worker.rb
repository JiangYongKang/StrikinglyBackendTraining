class AsyncSendMessageWorker

  include Sidekiq::Worker
  sidekiq_options queue: :default, backtrace: true, retry: false

  # 如何使用：
  # 创建异步作业：AsyncSendMessageWorker.perform_async(xxx, xxx, xxx)
  # 创建延时异步作业: AsyncSendMessageWorker.perform_in(1.minutes, xxx, xxx)
  # 指定时间创建异步作业: AsyncSendMessageWorker.perform_at(1.minutes.from_now, xxx, xxx)
  def perform(*args)
    logger.info 'Asynchronous execution...'
  end
end
