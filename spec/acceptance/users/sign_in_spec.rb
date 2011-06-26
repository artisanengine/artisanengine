require 'acceptance/acceptance_helper'

feature 'Sign In', %q{
  In order to access site features requiring authorization
  As a registered user
  I want to sign in to my account.
} do
  
  background do
    # Given there is a user,
    Factory :user, email:    'test@test.com',
                   password: 'testuser', 
                   frame:    find_or_create_frame( 'example.com' )

    # And I am browsing the Example frame,
    browse_frame 'example.com'

    # And I am on the sign in page,
    visit sign_in_page
  end

  scenario "A registered user can sign in to his account with valid credentials" do
    # When I fill in valid credentials and click Sign In,
    fill_in 'E-Mail',   with: 'test@test.com'
    fill_in 'Password', with: 'testuser'
    click_button 'Sign In'
    
    # Then I should be signed in.
    page.should have_content 'Welcome back'
  end
  
  scenario "A registered user cannot sign in to his account with invalid credentials" do
    # When I fill in invalid credentials and click Sign In,
    fill_in 'E-Mail',   with: 'test@test.com'
    fill_in 'Password', with: 'wrong'
    click_button 'Sign In'
    
    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not be signed in.
    page.should have_no_content 'Welcome back'
  end
  
  scenario "A registered user cannot sign in to his account from another frame" do
    # Given I am on the Haus Leather frame,
    browse_frame 'hausleather.com'
    
    # When I sign in as the user from the Example frame,
    sign_in_as 'test@example.com', 'testuser'

    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not be signed in.
    page.should have_no_content 'Welcome back'    
  end
end