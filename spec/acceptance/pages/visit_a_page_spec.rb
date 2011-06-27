require 'acceptance/acceptance_helper'

feature 'Visit a Page', %q{
  In order to view information about an artisan
  As a visitor
  I want to visit a page.
} do
  
  background do
    # Given an Example.com artisan has created a page,
    Page.generate title: 'Example Page'

    # And a Haus Leather artisan has created a page,
    Page.generate title: 'Haus Leather Page', frame: use_frame( 'hausleather.com' )
    
    # And I am a visitor browsing Example's frame,
    assume_role :visitor, in_frame: 'example.com'
  end
  
  scenario "A visitor can visit a page in the current frame" do        
    # When I visit the Example page,
    visit_page 'Example Page'
    save_and_open_page
    
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