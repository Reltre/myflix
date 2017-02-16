require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Myflix
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.active_job.queue_adapter = :sidekiq
    config.assets.enabled = true
    config.autoload_paths << "#{Rails.root}/lib"
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end

    Sidekiq.configure_server do |config|
      config.redis = { url: 'redis://redistogo:454ab082d5659fd2272503b3d0dc9845@koi.redistogo.com:11185/' }
    end

    Sidekiq.configure_client do |config|
      config.redis = { url: 'redis://redistogo:454ab082d5659fd2272503b3d0dc9845@koi.redistogo.com:11185/' }
    end

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      if File.exist? env_file
        YAML.load(File.open(env_file)).each do |key, value|
          ENV[key.to_s] = value
        end
      end
    end
  end
end
