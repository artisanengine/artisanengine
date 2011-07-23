require 'acceptance/acceptance_helper'

feature 'Artisan Authentication Required for Artisan-Only Functions', %q{
  In order to protect artisan-specific functionality
  As an artisan
  I want to be required to authenticate to access artisan-specific actions.
} do
  
  scenario "A user is required to authenticate before accessing an artisan-only action" do
    # Given I am browsing the default frame,
    browse_frame
    
    # When I attempt to access an artisan-only function,
    visit new_page_page
    
    # Then I should be prompted to sign in.
    page.current_path.should == artisan_sign_in_page
  end
  
  scenario "An engineer can bypass artisan authentication" do
    # Given I am browsing the default frame,
    browse_frame
    
    # And I am signed in as an engineer,
    sign_in_as_engineer
    
    # When I attempt to access an artisan-only function,
    visit new_page_page
    
    # Then I should bypass authentication.
    page.current_path.should == new_page_page
  end
end