require 'acceptance/acceptance_helper'

feature 'Sign Out', %q{
  In order to return to anonymity
  As a registered user
  I want to sign out of my account.
} do
  
  background do
    # Given I am browsing the Example frame,
    browse_frame 'example.com'
    
    # And there is a user in the Example frame,
    User.generate email: 'test@test.com', password: 'testuser'
    
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
    