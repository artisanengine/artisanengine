require 'acceptance/acceptance_helper'

feature 'Create a Display Case', %q{
  In order to organize my goods
  As an artisan
  I want to create a display case.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I am on the new display case page,
    visit new_display_case_page
  end
  
  scenario "An artisan can create a display case with valid attributes" do
    # When I fill in valid attributes for the collection,
    fill_in 'Name', with: 'The Good Shit'
    
    # And I click Create Display Case,
    click_button 'Create Display Case'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my new display case.
    page.should have_selector '.display_case', name: 'The Good Shit'
  end
  
  scenario "An artisan cannot create a display case with invalid attributes" do
    # When I fill in invalid attributes for the display case,
    fill_in 'Name', with: ''
    
    # And I click Create Display Case,
    click_button 'Create Display Case'
    
    # Then I should see an alert,
    page_should_have_alert
    
    # And there should be no display cases.
    DisplayCase.count.should be 0
  end
end