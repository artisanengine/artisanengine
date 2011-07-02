require 'acceptance/acceptance_helper'

feature 'Development Interface', %q{
  In order to see all my engineer-specific functionality
  As an engineer
  I want to see a development interface.
} do
  
  background do
    # Given I am signed in as an engineer,
    sign_in_as_engineer
  end
  
  scenario 'An engineer can visit the development interface' do
    # When I visit the development interface,
    visit development_interface
    
    # Then I should see the development interface.
    page.should have_content 'Development'
  end
end