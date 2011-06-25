source 'http://rubygems.org'

# ------------------------------------------------------------------
# Environment-Independent Gems

gem 'rails',                  '3.1.0.rc4'   # Update this when 3.1.0 comes out.
gem 'thin',                   '1.2.11'      # Run Thin to match Heroku.

# Utilities.
gem 'rake',                   '0.8.7'       # Lock rake at 0.8.7 for Heroku.

# Authentication and authorization.
gem 'devise',                 '1.4.0'
gem 'cancan',                 '1.6.5'

# Controller-layer enhancements.
gem 'decent_exposure', 			  '1.0.1'

# View-layer enhancements.
gem 'formtastic',						  '1.2.4'
gem 'haml',									  '3.1.2'
gem 'compass',                git: 'https://github.com/chriseppstein/compass.git', branch: 'rails31'

# Asset pipeline enhancements.
gem 'sass-rails',             '3.1.0.rc.2'  # Enable SASS templates.
gem 'coffee-script',          '2.2.0'       # Enable CoffeeScript.
gem 'uglifier',               '1.0.0'       # Default asset compressor.
gem 'jquery-rails',           '1.0.11'      # Serve JQuery through the asset pipeline.

# ------------------------------------------------------------------
# Environment-Specific Gems

group :test do
  # Unit testing.
  gem 'rspec-rails',				  '2.6.1'       # Unit testing and generators.
  gem 'valid_attribute',      '1.0.0'       # Useful BDD matchers.
  
	# Integration testing.
	gem 'capybara',						  '1.0.0'
	gem 'capybara-webkit',      '1.0.0.beta4' # Headless JS driver.
	gem 'launchy',              '0.4.0'
	gem 'watchr',							  '0.7'
	gem 'spork',							  '0.9.0rc8'
end

group :development, :test do
  gem 'sqlite3',              '1.3.3'       # Use SQLite DB in testing and development.

  # Sample data generation.
	gem 'fabrication',				  '1.0.0'
	gem 'faker',							  '0.9.5'
end

group :production do
  gem 'therubyracer-heroku',  '0.8.1.pre3'  # JS Runtime for Heroku.
  gem 'pg',                   '0.11.0'      # Use Postgres DB in production to match Heroku.
end
