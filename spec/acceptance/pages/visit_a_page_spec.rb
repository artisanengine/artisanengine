require 'acceptance/acceptance_helper'

feature 'Visit a Page', %q{
  In order to view information about an artisan
  As a visitor
  I want to visit a page.
} do
  
  background do
    # Given a default artisan has created a page,
    Page.generate title: 'Example Page', frame: use_frame( 'ae.test' )

    # And a Haus Leather artisan has created a page,
    Page.generate title: 'Haus Leather Page', frame: use_frame( 'hausleather.test' )
    
    # And I am a visitor browsing Example's frame,
    assume_role :visitor, in_frame: 'ae.test'
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