require 'acceptance/acceptance_helper'

feature 'Engineer Authentication Required for Engineer-Only Functions', %q{
  In order to protect engineer-specific functionality
  As an engineer
  I want to be required to authenticate to access engineer-only actions.
} do
  
  scenario "A user is required to authenticate before accessing an engineer-only action" do
    # When I attempt to access an engineer-specific function,
    visit new_frame_page
    
    # Then I should be prompted to sign in.
    page.current_path.should == engineer_sign_in_page
  end
end