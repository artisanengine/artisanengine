require 'acceptance/acceptance_helper'

feature 'Create a Frame', %q{
  In order to set up a new artisan
  As an engineer
  I want to create a frame.
} do
  
  background do
    # Given I am on the New Frame page,
    visit new_frame_page
  end
  
  scenario "An engineer can create a frame with valid attributes" do
    # When I create a frame with valid attributes,
    create_frame name: 'Haus Leather'
    
    # Then I should see a notice,
    page.should have_selector '.notice'
    
    # And I should see my new frame.
    page.should have_content 'Haus Leather'
  end
  
  scenario "An engineer cannot create a frame with invalid attributes" do
    # When I create a frame with invalid attributes,
    create_frame name: 'Haus Leather', domain: ''
    
    # Then I should see an alert,
    page.should have_selector '.alert'
    
    # And I should not see my new frame.
    page.should have_no_content 'Haus Leather'
  end
end