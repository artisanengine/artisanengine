# Clean up Dragonfly images after each test run.

RSpec.configure do |config|
  config.after :suite do
    FileUtils.rm_r( "#{ Rails.root }/public/system/dragonfly/test" )
  end
end