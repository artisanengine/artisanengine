source 'http://rubygems.org'

# ------------------------------------------------------------------
# Environment-Independent Gems

gem 'rails',                  '3.1.0.rc4'   # Update this when 3.1.0 comes out.
gem 'thin',                   '1.2.11'      # Run Thin to match Heroku.

# Utilities.
gem 'rake',                   '0.8.7'       # Lock rake at 0.8.7 for Heroku.
gem 'RedCloth',               '4.2.7'       # Text handling.
gem 'dragonfly',              '0.9.4'       # Image handling.
gem 'fog',                    '0.9.0'       # S3 support for Dragonfly.
gem 'cells',                  '3.6.2'       # Reusable view components.
gem 'friendly_id',            '3.3.0.alpha2'     # SEO-friendly URLs.

# Authentication and authorization.
gem 'devise',                 '1.4.2'       # Authentication.

# Controller-layer enhancements.
gem 'decent_exposure',        '1.0.1'

# View-layer enhancements.
gem 'formtastic',						  '1.2.4'       # Better forms.
gem 'haml',									  '3.1.2'       # HTML haiku.
gem 'compass',                git: 'https://github.com/chriseppstein/compass.git', branch: 'rails31'

# Asset pipeline enhancements.
gem 'sass-rails',             '3.1.0.rc.4'  # Enable SASS templates.
gem 'coffee-script',          '2.2.0'       # Enable CoffeeScript.
gem 'uglifier',               '1.0.0'       # Default asset compressor.
gem 'jquery-rails',           '1.0.11'      # Serve JQuery through the asset pipeline.

# Demo data.
gem 'factory_girl_rails',		  '1.0.1'       # Sample model generation.
gem 'faker',							    '0.9.5'       # Sample data generation.

# ------------------------------------------------------------------
# Environment-Specific Gems

group :test do
  # Unit testing.
  gem 'rspec-rails',				  '2.6.1'       # Unit testing and generators.

	# Integration testing.
	gem 'rspec-cells',          '0.0.5'       # Integration testing for Cells.
	gem 'capybara',						  '1.0.0'       # All-purpose integration testing.
	gem 'capybara-webkit',      '1.0.0.beta4' # Headless JS driver.
	gem 'database_cleaner',     '0.6.7'       # For JS testing.
	gem 'launchy',              '0.4.0'
	gem 'watchr',							  '0.7'         # All-purpose automation.
	gem 'spork',							  '0.9.0rc8'    # Faster tests.
end

group :development, :test do
  gem 'sqlite3',              '1.3.3'       # Use SQLite DB in testing and development.
end

group :production do
  gem 'therubyracer-heroku',  '0.8.1.pre3'  # JS Runtime for Heroku.
  gem 'pg',                   '0.11.0'      # Use Postgres DB in production to match Heroku.
end
