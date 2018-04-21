require_relative 'boot'

require 'rails/all'
require 'csv' #Use rubys built in CSV library

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    #How to override the unpermitted parameters to hash issue From: 
    #https://stackoverflow.com/questions/43551676/unable-to-convert-unpermitted-parameters-to-hash-ruby-on-rails-app-error
    config.action_controller.permit_all_parameters = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
