class HardWorker
  include Sidekiq::Worker

  # TODO: 调用方式
  #       HardWorker.perform_async(100, 200, 300)
  def perform(*args)
    puts "#{DateTime.now.to_s(:db)} ".color(:red) + "HardWorker#perform #{args.to_s}".color(:yellow)
  end
end
