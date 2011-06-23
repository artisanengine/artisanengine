require 'spec_helper'

# Require acceptance/support files.
Dir[ "#{ Rails.root }/spec/acceptance/support/**/*.rb" ].each { |f| require f }

# Set default JS driver.
Capybara.javascript_driver = :webkit