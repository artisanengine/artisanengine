require 'acceptance/acceptance_helper'

feature 'Engineer Sign Out', %q{
  In order to return to anonymity
  As an engineer
  I want to sign out of my account.
} do
  
  background do
    # Given I am signed in as an engineer,
    sign_in_as_engineer
  end
  
  scenario "An engineer can sign out of his account" do
    # When I visit the sign out page,
    visit engineer_sign_out_page
    
    # Then I should be signed out.
    page.should have_no_content 'Welcome back'
  end
end
