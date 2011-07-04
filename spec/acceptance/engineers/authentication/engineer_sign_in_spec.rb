require 'acceptance/acceptance_helper'

feature 'Engineer Sign In', %q{
  In order to access the administrative features of ArtisanEngine
  As an engineer
  I want to sign in to my account.
} do
  
  background do
    # Given there is an engineer,
    @valid_email    = 'bob@thebuilder.com'
    @valid_password = 'buildstuff'
    Engineer.generate email: @valid_email, password: @valid_password

    # And I am on the engineer sign in page,
    visit engineer_sign_in_page
  end

  scenario "An engineer can sign in to his account with valid credentials" do
    # When I sign in with valid credentials,
    sign_in_as_engineer email: @valid_email, password: @valid_password
    
    # Then I should be signed in.
    page.should have_content 'Signed in'
  end
  
  scenario "An engineer cannot sign in to his account with invalid credentials" do
    # When I sign in with invalid credentials,
    sign_in_as_engineer email: @valid_email, password: 'iamnotacrook'
    
    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not be signed in.
    page.should have_no_content 'Signed in'
  end
end