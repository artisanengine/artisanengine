require 'acceptance/acceptance_helper'

feature 'Visit a Page', %q{
  In order to view information about an artisan
  As a patron
  I want to visit a page.
} do
  
  background do
    # Given a frame exists,
    create_test_frame
    
    # And the example artisan has created a page,
    create_page title: 'Magical Page'
  end

  scenario "A patron can visit a page" do
    # When I visit the example artisan's page,
    visit "/pages/#{ Page.first.id }"
    
    # Then I should see the page title.
    page.should have_content 'Magical Page'
  end
  
  scenario "A patron can only visit pages in her current frame" do
    # Given there is a hausleather frame,
    create_frame domain: 'hausleather.com'
    
    # And I am browsing the hausleather frame,
    ENV[ "FORCE_FRAME" ] = 'hausleather.com'
    
    # And hausleather has created a page,
    create_page title: 'Haus Leather Page'
        
    # When I visit the haus leather page,
    visit_page 'Haus Leather Page'
    
    # Then I should see the page,
    page.should have_content 'Haus Leather Page'

    # And when I visit the example page,
    visit_page 'Magical Page'
    
    # Then I should not see the page.
    page.should have_no_content 'Magical Page'
    
    # And when I am browsing the example frame,
    ENV[ "FORCE_FRAME" ] = 'example.com'
    
    # And I visit the haus leather page,
    visit_page 'Haus Leather Page'
    
    # Then I should not see the page.
    page.should have_no_content 'Haus Leather Page'
    
    # And when I visit the example page,
    visit_page 'Magical Page'
    
    # Then I should see the example page.
    page.should have_content 'Magical Page'
  end
    
end