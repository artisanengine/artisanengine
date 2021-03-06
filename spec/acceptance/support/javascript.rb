require 'database_cleaner'

RSpec.configure do |config|
  # Selenium doesn't play nice with transactional fixtures, so we have to handle
  # the database ourselves.
  config.use_transactional_fixtures = false
  
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do                                  
    if example.metadata[ :js ]
      Capybara.current_driver  = example.metadata[ :js_driver ] || :webkit        
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.start
    end
  end

  config.after :each do
    Capybara.use_default_driver if example.metadata[ :js ]
    DatabaseCleaner.clean
  end
end