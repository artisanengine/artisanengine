require 'spec_helper'

# Require acceptance/support files.
Dir[ "#{ Rails.root }/spec/acceptance/support/**/*.rb" ].each { |f| require f }

# Set default app host.
Capybara.app_host = 'http://ae.test:7357'