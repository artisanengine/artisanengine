require 'acceptance/acceptance_helper'

feature 'Visit a Good', %q{
  In order to view an artisan's phenomenal swag
  As a visitor
  I want to visit a good.
} do
  
  background do
    # Given a test artisan has created a good,
    Good.generate name: 'Phenomenal Swag'
    
    # And a Haus Leather artisan has created a good,
    Good.generate name: 'Rocking Sauce', frame: use_frame( 'hausleather.test' )
  
    # And I am browsing the test frame,
    browse_frame
  end
  
  scenario "A visitor can visit a good in the current frame" do
    # When I visit the good's page,
    visit good_page_for 'Phenomenal Swag'
    
    # Then I should see the good.
    page.should have_content 'Phenomenal Swag'
  end
  
  scenario "A visitor cannot visit a good in a different frame" do
    # When I visit the Haus Leather good's page,
    visit good_page_for 'Rocking Sauce'
    
    # Then I should not see the good.
    page.should have_no_content 'Rocking Sauce'
  end
end