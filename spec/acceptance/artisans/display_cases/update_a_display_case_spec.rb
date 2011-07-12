require 'acceptance/acceptance_helper'

feature 'Update a Display Case', %q{
  In order to re-organize my goods
  As an artisan
  I want to update a display case.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a display case,
    DisplayCase.generate name: 'Stuff'
    
    # And I am on the Edit Display Case page,
    visit edit_display_case_page_for 'Stuff'
  end
  
  scenario "An artisan can update a display case with valid attributes" do
    # When I fill in valid new attributes for the display case,
    fill_in 'Name', with: 'New Stuff'
    
    # And I click Update Display Case,
    click_button 'Update Display Case'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my updated display case.
    page.should have_selector '.display_case', text: 'New Stuff'
  end
  
  scenario "An artisan cannot update a display case with invalid attributes" do
    # When I fill in invalid new attributes for the display case,
    fill_in 'Name', with: ''
    
    # And I click Update Display Case,
    click_button 'Update Display Case'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And my display case's attributes should not change.
    DisplayCase.last.name.should == 'Stuff'
  end
    
end