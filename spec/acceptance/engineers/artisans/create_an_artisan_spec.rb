require 'acceptance/acceptance_helper'

feature 'Create an Artisan', %q{
  In order to give an artisan access to her frame
  As an engineer
  I want to create an artisan.
} do
  
  background do
    # Given I am signed in as an engineer,
    sign_in_as_engineer
    
    # And a test frame exists,
    Frame.generate name: 'Test Frame'
    
    # And I am on the new artisan page,
    visit new_artisan_page
  end
  
  scenario "An engineer can sign up an artisan with valid attributes" do
    # When I select a frame,
    select 'Test Frame', from: 'Frame'
        
    # And I fill in valid account information,
    fill_in 'First Name',            with: 'Kvothe'
    fill_in 'Last Name',             with: 'the Bloodless'
    fill_in 'E-Mail',                with: 'k.arlidensson@university.org'
    fill_in 'Password',              with: 'felurian'
    fill_in 'Password Confirmation', with: 'felurian'
    
    # And I click Create Artisan,
    click_button 'Create Artisan'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see the new artisan's name and E-Mail
    for content in %w( Kvothe Bloodless k.arlidensson@university.org )
      page.should have_content content
    end
  end
    
  scenario "An engineer cannot sign up an artisan with invalid attributes" do
    # When I fill in invalid information for the artisan,
    fill_in 'First Name',            with: 'Kvothe'
    fill_in 'Last Name',             with: 'the Bloodless'
    fill_in 'E-Mail',                with: 'tastes.like.plum'
    fill_in 'Password',              with: 'felurian'
    fill_in 'Password Confirmation', with: 'denna'
    
    # And I click Create Artisan,
    click_button 'Create Artisan'
    
    # Then I should see an alert,
    page_should_have_alert
    
    # And I should not see the artisan's information.
    page.should have_no_content 'Kvothe'
  end
end