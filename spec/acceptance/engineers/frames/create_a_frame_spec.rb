require 'acceptance/acceptance_helper'

feature "Create a Frame", %q{
  In order to set up a new artisan
  As an engineer
  I want to create a frame.
} do
  
  background do
    # Given I am signed in as an engineer,
    sign_in_as_engineer

    # And I am on the new frame page,
    visit new_frame_page
  end

  scenario "An engineer can create a frame with valid attributes" do
    # When I fill in valid information for the frame,
    fill_in 'Name',   with: 'Haus Leather'
    fill_in 'Domain', with: 'hausleather.com'
    
    # And I click the Create Frame button,
    click_button 'Create Frame'

    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my new frame's name and domain.
    page.should have_content 'Haus Leather'
    page.should have_content 'hausleather.com'
  end
  
  scenario "An engineer cannot create a frame with invalid attributes" do
    # When I fill in invalid information for the frame,
    fill_in 'Name',   with: 'Haus Leather'
    fill_in 'Domain', with: ''
    
    # And I click the Create Frame button,
    click_button 'Create Frame'
    
    # Then I should see an alert,
    page_should_have_alert
    
    # And I should not see my new frame's name.
    page.should have_no_content 'Haus Leather'
  end
end