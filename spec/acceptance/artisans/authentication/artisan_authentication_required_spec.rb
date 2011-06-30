require 'acceptance/acceptance_helper'

feature 'Artisan Authentication Required for Artisan-Only Functions', %q{
  In order to protect artisan-specific functionality
  As an artisan
  I want to be required to authenticate to access artisan-specific actions.
} do
  
  scenario "A user is required to authenticate before accessing an artisan-specific function" do
    # Given I am browsing the test frame,
    browse_frame
    
    # When I attempt to access an artisan-specific function,
    visit new_page_page
    
    # Then I should be prompted to sign in.
    page.current_path.should == artisan_sign_in_page
  end
end