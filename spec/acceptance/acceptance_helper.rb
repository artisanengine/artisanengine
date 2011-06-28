require 'spec_helper'
require 'database_cleaner'

# Require acceptance/support files.
Dir[ "#{ Rails.root }/spec/acceptance/support/**/*.rb" ].each { |f| require f }

# Set default app host.
Capybara.app_host = 'http://ae.test:7357'