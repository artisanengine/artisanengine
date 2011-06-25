require 'acceptance/acceptance_helper'

feature 'Create an Artisan User', %q{
  In order to set up my artisans to access their frames
  As an engineer
  I want to create an artisan user.
} do
  
  background do
    # Given I have created an Example frame,
    create_frame
    
    # And I am on the new user page,
    visit new_user_page
  end
  
  scenario "An engineer can create an artisan user with valid attributes" do
    # When I create an 'Artisan' user with valid attributes,
    create_user role: 'Artisan', email: 'test@example.com'

    # Then I should see my new user.
    page.should have_content 'test@example.com'
  end
    
  scenario "An engineer cannot create an artisan user with invalid attributes" do
    # When create an 'Artisan' user with invalid attributes,
    create_user role: 'Artisan', email: 'test@example.com', first_name: ''

    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not see my user.
    page.should have_no_content 'test@example.com'
  end
end