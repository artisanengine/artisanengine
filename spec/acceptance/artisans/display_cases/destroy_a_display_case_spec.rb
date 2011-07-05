require 'acceptance/acceptance_helper'

feature 'Destroy a Display Case', %q{
  In order to re-organize my goods
  As an artisan
  I want to destroy a display case.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a display case,
    DisplayCase.generate name: 'Stuff'
    
    # And I am on the Manage Display Cases page,
    visit manage_display_cases_page
  end
  
  scenario "An artisan can destroy a display case" do
    # When I click the Delete link for the display case,
    within '.display_case' do
      click_link 'Delete'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see no display cases.
    page.should have_no_selector '.display_case'
  end
end