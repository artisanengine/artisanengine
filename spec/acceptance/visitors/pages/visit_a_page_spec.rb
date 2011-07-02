require 'acceptance/acceptance_helper'

feature 'Visit a Page', %q{
  In order to view information about an artisan
  As a visitor
  I want to visit a page.
} do
  
  background do
    # Given a test artisan has created a page,
    Page.generate title: 'Example Page'

    # And a Haus Leather artisan has created a page,
    Page.generate title: 'Haus Leather Page', frame: use_frame( 'hausleather.test' )
    
    # And I am a visitor browsing the test frame,
    browse_frame
  end
  
  scenario "A visitor can visit a page in the current frame" do        
    # When I visit the Example page,
    visit_page 'Example Page'

    # Then I should see the Example page.
    page.should have_content 'Example Page'
  end
  
  scenario "A visitor cannot visit a page in a different frame" do
    # When I visit the Haus Leather page,
    visit_page 'Haus Leather Page'
    
    # Then I should not see the page,
    page.should have_no_content 'Haus Leather Page'
  end
    
end