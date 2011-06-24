require 'acceptance/acceptance_helper'

feature 'Visit a Page', %q{
  In order to view information about an artisan
  As a patron
  I want to visit a page.
} do
  
  background do
    # Given an Example artisan has created a page,
    create_page title: 'Example Page', in_frame: 'example.com'
    
    # And a Haus Leather artisan has created a page,
    create_page title: 'Haus Leather Page', in_frame: 'hausleather.com'
    
    # And I am browsing the Example frame,
    browse_frame 'example.com'
  end
  
  scenario "A patron can visit a page in her current frame" do        
    # When I visit the Example page,
    visit_page 'Example Page'
    
    # Then I should see the Example page.
    page.should have_content 'Example Page'
  end
  
  scenario "A patron cannot visit a page in a different frame" do
    # When I visit the Haus Leather page,
    visit_page 'Haus Leather Page'
    
    # Then I should not see the page,
    page.should have_no_content 'Haus Leather Page'
  end
    
end