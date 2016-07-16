require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QueueFlow
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    config.time_zone = 'Europe/Moscow'

    config.active_record.raise_in_transactional_callbacks = true

    config.eager_load_paths += %W(
    #{config.root}/app/workers
    #{config.root}/lib
    )
    
    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_spec: false,
        helper_specs: false,
        routing_specs: false,
        request_specs: false,
        controller_spec: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.cache_store = :redis_store, 'redis://localhost:6379/0/cache', { expires_in: 90.minutes }
  end
end
