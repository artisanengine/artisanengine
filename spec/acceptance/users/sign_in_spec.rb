require 'acceptance/acceptance_helper'

feature 'Sign In', %q{
  In order to access site features requiring authorization
  As a registered user
  I want to sign in to my account.
} do
  
  background do
    # Given I am browsing the Example frame,
    browse_frame 'example.com'
    
    # And there is a user,
    create_user email: 'test@example.com', password: 'testuser'
    
    # And I am signed out,
    Capybara.reset_sessions!
    
    # And I am on the sign in page,
    visit sign_in_page
  end

  scenario "A registered user can sign in to his account with valid credentials" do
    # When I fill in valid credentials and click Sign In,
    fill_in 'E-Mail',   with: 'test@example.com'
    fill_in 'Password', with: 'testuser'
    click_button 'Sign In'
    
    # Then I should be signed in.
    page.should have_content 'Welcome back'
  end
  
  
  scenario "A registered user user cannot sign in to his account with invalid credentials" do
    # When I fill in invalid credentials and click Sign In,
    fill_in 'E-Mail',   with: 'test@example.com'
    fill_in 'Password', with: 'wrong'
    click_button 'Sign In'
    
    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not be signed in.
    page.should have_no_content 'Welcome back'
  end
end