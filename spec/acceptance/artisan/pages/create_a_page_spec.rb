require 'acceptance/acceptance_helper'

feature 'Create a Page', %q{
  In order to present basic content to my patrons
  As an artisan
  I want to create a page.
} do
  
  background do
    # Given I am browsing the Example.com frame,
    browse_frame 'example.com'
  end
  
  scenario "An artisan can create a page with valid attributes" do
    # When I create a page with valid attributes,
    create_page
    
    # Then I should see a notice,
    page.should have_selector '.notice'
    
    # And I should see my page.
    page.should have_content 'About Me'
  end
  
  scenario "An artisan cannot create a page with invalid attributes" do
    # When I create a page with invalid attributes,
    create_page title: ''
    
    # Then I should see an error,
    page.should have_selector '.error'
    
    # And there should be no pages.
    Page.count.should == 0
  end
end