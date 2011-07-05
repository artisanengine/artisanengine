require 'acceptance/acceptance_helper'

feature 'Auto-Create Featured Display Case', %q{
  In order to have a standardized place to put my featured items
  As an artisan
  I want a Featured display case to be auto-created for me.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I am on the manage display cases page,
    visit manage_display_cases_page
  end
  
  scenario "A Featured display case is automatically created when an artisan's frame is created" do
    # Then I should see a Featured display case,
    page.should have_selector '.display_case', text: 'Featured'
    
    # And I should not be able to edit or delete the Featured display case.
    within '.display_case', text: 'Featured' do
      page.should_not have_content 'Edit'
      page.should_not have_content 'Delete'
    end
  end
end