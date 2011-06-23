# Creates a frame for acceptance tests to run in.

RSpec.configure do |config|
  config.before :suite do
    Fabricate( :frame, domain: 'example.com', name: 'Test Frame' ) unless Frame.find_by_domain( 'example.com' )
  end
end