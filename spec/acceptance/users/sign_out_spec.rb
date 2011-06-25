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
    create_user
  end
  
  scenario "A user can sign out of his account" do
    # Given I am signed in,
    page.should have_content 'Welcome back'
    
    # When I visit the sign out page,
    visit '/sign_out'
    
    # Then I should be signed out.
    page.should have_no_content 'Welcome back'
  end
end
    