require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myfirstshift
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'Central Time (US & Canada)'
    config.active_record.default_timezone = :local
    config.action_mailer.preview_path = "#{Rails.root}/lib/mailer_previews"
  end
end
