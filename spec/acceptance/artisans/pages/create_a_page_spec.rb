require 'acceptance/acceptance_helper'

feature 'Create a Page', %q{
  In order to present basic content to my patrons
  As an artisan
  I want to create a page.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I am on the new page page,
    visit new_page_page
  end
  
  scenario "An artisan can create a page with valid attributes" do
    # When I fill in valid information for the page,
    fill_in 'Title', with: 'About Me'
    
    # And I click Create Page,
    click_button 'Create Page'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my page and my page's title.
    page.should have_selector '.page', text: 'About Me'
  end
  
  scenario "An artisan cannot create a page with invalid attributes" do
    # When I fill in invalid information for the page,
    fill_in 'Title',   with: ''
    
    # And I click Create Page,
    click_button 'Create Page'
    
    # Then I should see an alert,
    page_should_have_alert
    
    # And there should be no pages.
    Page.count.should be 0
  end
end