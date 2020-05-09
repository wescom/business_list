require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BusinessList
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.time_zone = 'Pacific Time (US & Canada)'

    config.filter_parameters += [:password, :password_confirmation, :credit_card, :credit_card_number, :card_security_code]
  
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"
  end
end
