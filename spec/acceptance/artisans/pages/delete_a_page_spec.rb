require 'acceptance/acceptance_helper'

feature 'Delete a Page', %q{
  In order to remove pages,
  As an artisan
  I want to delete a page.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a page,
    Page.generate title: 'Old Page'
    
    # And I am on the manage pages page,
    visit manage_pages_page
  end
  
  scenario "An artisan can delete a page" do
    # When I click the Delete link on the first page,
    within '.page' do
      click_link 'Delete'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should not see my page.
    page.should have_no_selector '.page'
  end
end