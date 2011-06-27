# Clean up Dragonfly images after each test run.

RSpec.configure do |config|
  config.after :suite do
    dragonfly_test_folder = "#{ Rails.root }/public/system/dragonfly/test" 
    FileUtils.rm_r( dragonfly_test_folder ) if File.exists?( dragonfly_test_folder ) 
  end
end