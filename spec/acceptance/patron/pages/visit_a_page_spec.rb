require 'acceptance/acceptance_helper'

feature 'Visit a Page', %q{
  In order to view information about an artisan
  As a patron
  I want to visit a page.
} do
  
  background do
    # Given an artisan has created a page,
    create_page title: 'Magical Page'
  end
  
  scenario "A patron can visit a page" do
    # When I visit the page,
    visit "/pages/#{ Page.first.id }"
    
    # Then I should see the page title.
    page.should have_content 'Magical Page'
  end
end