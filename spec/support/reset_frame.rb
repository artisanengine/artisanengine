# Reset the FORCE_FRAME variable after each test.

RSpec.configure do |config|
  config.after :each do
    ENV[ "FORCE_FRAME" ] = nil
  end
end