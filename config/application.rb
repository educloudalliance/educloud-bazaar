require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Educloud
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.middleware.insert_before 0, Rack::Cors do
      debug true
      allow do
        origins '*'
        resource '/oauth/*', headers: :any, methods: %i[get post delete put patch options]
        resource '/api/v1/*', headers: :any, methods: %i[get post delete put patch options]
      end
    end

    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.log_tags = %i[subdomain uuid]
    config.logger = ActiveSupport::TaggedLogging.new(logger)

    Kaminari.configure do |config|
      config.page_method_name = :per_page_kaminari
    end
  end
end
