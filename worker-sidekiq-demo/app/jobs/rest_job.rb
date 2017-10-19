class RestJob < ApplicationJob
  queue_as :default

  # TODO: 调用方式:
  #       RestJob.set(wait: 10.second).perform_later(100, 200, 300)
  def perform(*args)
    puts "#{DateTime.now.to_s(:db)} ".color(:red) + "RestJob#perform #{args.to_s}".color(:yellow)
  end
end
