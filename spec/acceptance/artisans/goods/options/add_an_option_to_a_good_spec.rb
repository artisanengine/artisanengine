require 'acceptance/acceptance_helper'

feature 'Add an Option to a Good', %q{
  In order to specify different variations of my good
  As an artisan
  I want to add an option to my good.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good (with the default option),
    Good.generate name: 'Freeze Ray'
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end
  
  scenario "An artisan can add an option with valid attributes to a good" do
    # When I fill in valid attributes for a new option in the Add Option area,
    within '#add_option' do
      fill_in 'Name',          with: 'Size'
      fill_in 'Default Value', with: 'Small'
      click_button 'Add Option'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my new option,
    page.should have_selector '.option', text: 'Size'
    
    # And my variant should have the new option.
    within '.variant' do
      page.should have_content 'Small'
    end
  end
  
  scenario "An artisan cannot add an option with invalid attributes to a good" do
    # When I fill in invalid attributes for a new option in the Add Option area,
    within '#add_option' do
      fill_in 'Name',          with: 'Size'
      fill_in 'Default Value', with: ''
      click_button 'Add Option'
    end
    
    # Then I should see an alert,
    page_should_have_alert
    
    # And I should not see my new option.
    page.should have_no_selector '.option', text: 'Size'
  end
end