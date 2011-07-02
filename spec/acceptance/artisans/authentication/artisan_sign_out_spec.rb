require 'acceptance/acceptance_helper'

feature 'Artisan Sign Out', %q{
  In order to return to anonymity
  As an artisan
  I want to sign out of my account.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
  end
  
  scenario "An artisan can sign out of his account" do
    # When I visit the artisan sign out page,
    visit artisan_sign_out_page
    
    # Then I should be signed out.
    page.should have_no_content 'Welcome back'
  end
end
    