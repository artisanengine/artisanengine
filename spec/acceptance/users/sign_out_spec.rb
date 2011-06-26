require 'acceptance/acceptance_helper'

feature 'Sign Out', %q{
  In order to return to anonymity
  As a registered user
  I want to sign out of my account.
} do
  
  background do
    # Given I am browsing the Example frame,
    browse_frame 'example.com'
    
    # And there is a user,
    Factory :user, email:                 'test@test.com',
                   password:              'testuser', 
                   password_confirmation: 'testuser',
                   frame:                 Frame.find_by_domain( 'example.com' )
    
    # And I am signed in as that user,
    sign_in_as 'test@test.com', 'testuser'
  end
  
  scenario "A user can sign out of his account" do
    # When I visit the sign out page,
    visit sign_out_page
    
    # Then I should be signed out.
    page.should have_no_content 'Welcome back'
  end
end
    