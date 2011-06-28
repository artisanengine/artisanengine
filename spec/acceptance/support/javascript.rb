require 'database_cleaner'

RSpec.configure do |config|
  config.before :suite do                                 # Before entire suite,
    DatabaseCleaner.strategy = :transaction               # Set Transaction strategy.
    DatabaseCleaner.clean_with :truncation                # Clear the test DB.
  end

  config.before :each do                                  # Before each test,
    if example.metadata[ :js ]                            # If JS ...
      Capybara.current_driver  = :selenium                  # Use Capybara-Webkit.
      DatabaseCleaner.strategy = :truncation              # Set Truncation strategy.
    else                                                  # Otherwise...
      DatabaseCleaner.strategy = :transaction             # Set Transaction strategy.
      DatabaseCleaner.start                               # Start the transaction.
    end
  end

  config.after :each do                                    # After each test,
    Capybara.use_default_driver if example.metadata[ :js ] # Revert to default driver.
    DatabaseCleaner.clean                                  # Clean up.
  end
end