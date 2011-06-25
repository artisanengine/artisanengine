require 'spork'

ENV[ "RAILS_ENV" ] ||= 'test'

# ------------------------------------------------------------------
# Run before Spork forks.

Spork.prefork do
  # ------------------------------------------------------------------
  # Load Rails environment.
  
  require 'rails/application'
  Spork.trap_method( Rails::Application, :reload_routes! )
  
  require File.expand_path( "../../config/environment", __FILE__ )
  require 'rspec/rails'

  # Require spec/support files.
  Dir[ "#{ Rails.root }/spec/support/**/*.rb" ].each { |f| require f }
  
  # ------------------------------------------------------------------
  # Configure RSpec
  
  RSpec.configure do |config|
    config.mock_with :rspec                       # Mock Framework
    config.use_transactional_fixtures = true      # Run specs in transactions.
    
    # Only run :focus specs (if there are any).
    config.filter_run focus: true
    config.run_all_when_everything_filtered = true
  end
end

# ------------------------------------------------------------------
# Run each time Spork forks.

Spork.each_run do
  # Reload routes.
  require "#{ Rails.root }/config/routes"
end