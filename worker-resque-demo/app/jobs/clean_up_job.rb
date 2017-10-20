class CleanUpJob < ApplicationJob
  queue_as :default

  # TODO: 后续执行
  # CleanUpJob.perform_later(arg1, arg2)
  # TODO: 设置队列名称
  # CleanUpJob.set(queue: user.name).perform_later(arg1, arg2)
  # TODO: 设置延迟
  # CleanUpJob.set(wait: 1.week).perform_later(arg1, arg2)
  # TODO: 立即执行
  # CleanUpJob.perform_now(arg1, arg2)
  def perform(*args)
    puts "Start executing the cleanup task ..."
  end
end
