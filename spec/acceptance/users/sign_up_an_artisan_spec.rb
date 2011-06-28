require 'acceptance/acceptance_helper'

feature 'Sign Up an Artisan', %q{
  In order to give an artisan access to her frame
  As an engineer
  I want to sign up an artisan.
} do
  
  background do
    # Given I am signed in as an engineer,
    assume_role :engineer
    
    # And I am on the new user page,
    visit new_user_page
  end
  
  scenario "An engineer can sign up an artisan with valid attributes" do
    # When I select 'Artisan' as the role,
    select 'Artisan', from: 'Role'
    
    # And I fill in valid account information,
    fill_in_account_information first_name: 'Kvothe',
                                last_name:  'the Bloodless',
                                email:      'k.arlidensson@university.org'
    
    # And I click Sign Up,
    click_button 'Sign Up'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see the new artisan's name, E-Mail, and role.
    for content in [ "Kvothe", "the Bloodless", "k.arlidensson@university.org", "Artisan" ]
      page.should have_content content
    end
  end
    
  scenario "An engineer cannot sign up an artisan with invalid attributes" do
    # When I select 'Artisan' as the role,
    select 'Artisan', from: 'Role'
    
    # And I fill in invalid account information for the artisan,
    fill_in_account_information first_name: ''
    
    # And I click Sign Up,
    click_button 'Sign Up'
    
    # Then I should see an alert,
    page_should_have_alert
    
    # And I should not see the artisan's information.
    page.should have_no_content 'Kvothe'
  end
end