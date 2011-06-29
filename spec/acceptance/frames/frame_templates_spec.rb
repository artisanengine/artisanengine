require 'acceptance/acceptance_helper'

feature "Frame Themes", %q{
  In order to give each artisan's frame a unique look
  As an engineer
  I want to display custom themes.
} do
  
  background do
    # And I have created a custom application layout for the frame,
    create_test_theme_layout_with_content( 'Hello world!' )
    
    # And I am browsing the test frame,
    browse_frame
  end
  
  after do
    destroy_test_layout
  end
  
  scenario "A frame with a custom template displays its custom template" do
    # Given I am a visitor in the test frame,
    assume_role :visitor
    
    # When I visit the home page,
    visit '/'
    
    # Then I should see the custom template.
    page.should have_content 'Hello world!'
  end
  
  scenario "A frame without a custom template displays the default template" do
    # Given I am a visit in another frame,
    assume_role :visitor, in_frame: 'hausleather.test'
    
    # When I visit the home page,
    visit '/'
    
    # Then I should not see the custom template.
    page.should have_no_content 'Hello world!'
  end
end