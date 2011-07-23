require 'acceptance/acceptance_helper'

feature 'Password-Protect a Frame', %q{
  In order to prevent visitors from accessing a frame before it is populated
  As an engineer
  I want to password-protect a frame.
} do
  
  background do
    # Given there is a password-protected frame,
    frame = Frame.generate domain: 'ae.test'
    frame.settings << Setting.spawn( name: 'Password Protected', value: 'Yes' )
    
    # And I am browsing the ae.test frame,
    browse_frame 'ae.test'
  end
  
  scenario "A password-protected frame requires artisan-level authentication" do
    # When I visit the home page,
    visit '/'
    
    # Then I should be required to sign in.
    page.current_path.should == new_artisan_session_path
  end
  
  scenario "Engineers bypass password-protected frame authentication" do
    # If I am signed in as an engineer,
    sign_in_as_engineer
    
    # When I visit the home page,
    visit '/'
    
    # Then I should be on the home page.
    current_path.should == '/'
  end
end