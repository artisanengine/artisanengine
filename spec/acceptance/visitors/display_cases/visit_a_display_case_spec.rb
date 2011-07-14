require 'acceptance/acceptance_helper'

feature 'Visit a Display Case', %q{
  In order to view collections of an artisan's phenomenal swag
  As a visitor
  I want to visit a display case.
} do
  
  background do
    # Given there is a display case,
    swag = DisplayCase.generate name: 'Swag'
    
    # And there are three goods in the display case,
    3.times do
      good = Good.generate
      swag.goods << good
    end    
  end
  
  scenario "A visitor can visit a display case" do
    # When I visit the display case page,
    visit display_case_page_for 'Swag'
    
    # Then I should see the display case's title
    page.should have_content 'Swag'
    
    # And I should see the goods in the display case.
    page.should have_selector '.good', count: 3
  end
end