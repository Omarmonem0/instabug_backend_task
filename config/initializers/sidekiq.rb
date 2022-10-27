Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/2") }
    # schedule_file = "config/scheduler.yml"
    # if File.exist?(schedule_file) && Sidekiq.server?
    #   Sidekiq.schedule = YAML.load_file()
    #   Sidekiq::Scheduler.reload_schedule
    # end
    config.on(:startup) do
      Sidekiq.schedule = YAML.load_file(File.expand_path('../scheduler.yml', File.dirname(__FILE__)))
      Sidekiq::Scheduler.reload_schedule!
    end 
  end
  
  
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/2") }
  end
  