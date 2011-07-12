require 'acceptance/acceptance_helper'

feature 'Update a Page', %q{
  In order to update my basic content
  As an artisan
  I want to update a page.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And there is a page,
    Page.generate title: 'Outdated Page'
    
    # And I am on the edit page for the page,
    visit edit_page_page_for 'Outdated Page'
  end
  
  scenario "An artisan can update a page with valid attributes" do
    # When I fill in new valid information for my page,
    fill_in 'Title', with: 'Updated Page'
    
    # And I click Update Page,
    click_button 'Update Page'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my new page.
    page.should have_selector '.page', text: 'Updated Page'
  end
  
  scenario "An artisan cannot update a page with invalid attributes" do
    # When I fill in invalid information for my page,
    fill_in 'Title', with: ''
    
    # And I click Update Page,
    click_button 'Update Page'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And my page's information should not change.
    Page.last.title.should == 'Outdated Page'
  end
end