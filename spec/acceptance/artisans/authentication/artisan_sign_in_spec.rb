require 'acceptance/acceptance_helper'

feature 'Artisan Sign In', %q{
  In order to access my administrative interface
  As an artisan
  I want to sign in to my account.
} do
  
  background do
    # Given there is an artisan in the default frame,
    @valid_email    = 'artisan@example.com'
    @valid_password = 'makestuff'
    Artisan.generate email: @valid_email, password: @valid_password
  end

  scenario "An artisan can sign in to his account with valid credentials" do
    # Given I sign in as the artisan from the default frame with valid credentials,
    sign_in_as_artisan email: @valid_email, password: @valid_password
    
    # Then I should be signed in.
    page.should have_content 'Welcome back'
  end
  
  scenario "An artisan cannot sign in to his account with invalid credentials" do
    # And I sign in as an artisan with invalid credentials,
    sign_in_as_artisan email: @valid_email, password: 'nogo'
    
    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not be signed in.
    page.should have_no_content 'Welcome back'
  end
  
  scenario "An artisan cannot sign in to his account from another frame" do
    # And I sign in as the artisan from the default frame with valid credentials,
    sign_in_as_artisan email: @valid_email, password: @valid_password, in_frame: 'hausleather.test'

    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not be signed in.
    page.should have_no_content 'Welcome back'
  end
end