require 'acceptance/acceptance_helper'

feature 'Create an Artisan', %q{
  In order to give an artisan access to her frame
  As an engineer
  I want to create an artisan.
} do
  
  background do
    # Given I am signed in as an engineer,
    sign_in_as_engineer
    
    # And there is a test frame,
    Frame.generate name: 'Test Frame'
    
    # And I am on the new artisan page,
    visit new_artisan_page
  end
  
  scenario "An engineer can create an artisan with valid attributes" do
    # When I select the test frame,
    select 'Test Frame', from: 'Frame'
        
    # And I fill in valid account information,
    fill_in 'First Name',            with: 'Kvothe'
    fill_in 'Last Name',             with: 'the Bloodless'
    fill_in 'E-Mail',                with: 'k.arlidensson@university.arcanum'
    fill_in 'Password',              with: 'felurian'
    fill_in 'Password Confirmation', with: 'felurian'
    
    # And I click Create Artisan,
    click_button 'Create Artisan'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see the new artisan's full name and E-Mail.
    within '.artisan' do
      page.should have_content "Kvothe"
      page.should have_content "the Bloodless"
      page.should have_content "k.arlidensson@university.arcanum"
    end
  end
    
  scenario "An engineer cannot create an artisan with invalid attributes" do
    # When I fill in invalid information for the artisan,
    fill_in 'First Name',            with: 'Kvothe'
    fill_in 'Last Name',             with: 'the Bloodless'
    fill_in 'E-Mail',                with: 'tastes.like.plum'
    fill_in 'Password',              with: 'felurian'
    fill_in 'Password Confirmation', with: 'denna'
    
    # And I click Create Artisan,
    click_button 'Create Artisan'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And there should be no artisans.
    Artisan.count.should be 0
  end
end