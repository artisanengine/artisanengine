require 'acceptance/acceptance_helper'

feature 'Sign In', %q{
  In order to access site features requiring authorization
  As a registered user
  I want to sign in to my account.
} do
  
  background do
    # Given there is a user,
    @valid_email    = 'test@test.com'
    @valid_password = 'testuser'
    User.generate email: @valid_email, password: @valid_password

    # And I am browsing the default frame,
    browse_frame 'ae.test'

    # And I am on the sign in page,
    visit sign_in_page
  end

  scenario "A registered user can sign in to his account with valid credentials" do
    # When I sign in with valid credentials,
    sign_in_as @valid_email, @valid_password
    
    # Then I should be signed in.
    page.should have_content 'Welcome back'
  end
  
  scenario "A registered user cannot sign in to his account with invalid credentials" do
    # When I sign in with invalid credentials,
    sign_in_as @valid_email, 'wrong'
    
    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not be signed in.
    page.should have_no_content 'Welcome back'
  end
  
  scenario "A registered user cannot sign in to his account from another frame" do
    # Given I am on the Haus Leather frame,
    browse_frame 'hausleather.test'
    
    # When I sign in as the user from the Example frame,
    sign_in_as @valid_email, @valid_password

    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not be signed in.
    page.should have_no_content 'Welcome back'
  end
end