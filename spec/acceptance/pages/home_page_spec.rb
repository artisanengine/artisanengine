require 'acceptance/acceptance_helper'

feature 'Visit the Home Page', %q{
  In order to land somewhere when I visit the artisan's site
  As a visitor
  I want to visit the home page.
} do
  
  background do
    # Given I am browsing the test frame,
    browse_frame
  end
  
  scenario "A visitor can visit the home page" do
    # When I visit the home page,
    visit '/'
    
    # Then I should see the home page.
    page.should have_content 'Home'
  end
end