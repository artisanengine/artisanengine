require File.expand_path( '../boot', __FILE__ )
require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require( :default, Rails.env ) if defined?( Bundler )

# Skips all of the nasty and bloated old Compass Rails integration.
# Only necessary until Compass 0.12 becomes stable.
# https://gist.github.com/1184816
module Compass
  RAILS_LOADED = true
end

module ArtisanEngine
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W( #{ Rails.root }/lib #{ Rails.root }/app/models/adjustments #{ Rails.root }/app/models/mail_forms )

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [ :password, :password_confirmation ]

    # Enable the asset pipeline.
    config.assets.enabled = true
    
    # Add Compass styles to the asset pipeline.
    # Only necessary until Compass 0.12 becomes stable.
    # https://gist.github.com/1184816
    config.sass.load_paths << Compass::Frameworks['compass'].stylesheets_directory
    config.sass.load_paths << Compass::Frameworks['blueprint'].stylesheets_directory
    
    # Add theme asset paths.
    for theme in %w( emmysorganics peggyskemp )
      config.assets.paths << "#{ Rails.root }/app/themes/#{ theme }/assets/images"
      config.assets.paths << "#{ Rails.root }/app/themes/#{ theme }/assets/stylesheets"
      config.assets.paths << "#{ Rails.root }/app/themes/#{ theme }/assets/javascripts"
    end
    
    # Insert Dragonfly middleware.
    config.middleware.insert 0, 'Dragonfly::Middleware', :images
  
    # Configure generators.
    config.generators do |g|
      g.template_engine :haml
      g.test_framework  :rspec
    end  
  end
end
