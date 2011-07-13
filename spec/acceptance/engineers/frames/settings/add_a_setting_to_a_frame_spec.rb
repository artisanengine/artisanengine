require 'acceptance/acceptance_helper'

feature "Add a Setting to a Frame", %q{
  In order to give each artisan's frame unique settings
  As an engineer
  I want to add a setting to a frame.
} do
  
  background do
    # Given I am signed in as an engineer,
    sign_in_as_engineer
    
    # And I have created a Frame,
    Frame.generate name: "Emmy's Organics"
    
    # And I am on the frame settings page,
    visit new_frame_setting_page_for "Emmy's Organics"
  end
  
  scenario "An engineer can add a setting with valid attributes" do
    # When I fill in valid attributes for the setting,
    fill_in 'Name',  with: 'Google Analytics'
    fill_in 'Value', with: 'ABCD-12345'
    
    # And I click Create Setting,
    click_button 'Create Setting'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see the new setting.
    within '.setting' do
      page.should have_content 'Google Analytics'
      page.should have_content 'ABCD-12345'
    end
  end
  
  scenario "An engineer cannot add a setting with invalid attributes" do
    # When I fill in invalid attributes for the setting,
    fill_in 'Name', with: ''
    
    # And I click Create Setting,
    click_button 'Create Setting'
    
    # Then I should see an error,
    page_should_have_error
    
    # And there should be no settings.
    Setting.count.should be 0
  end
end