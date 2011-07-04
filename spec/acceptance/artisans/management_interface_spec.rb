require 'acceptance/acceptance_helper'

feature 'Management Interface', %q{
  In order to see all my artisan-specific functionality
  As an artisan
  I want to see a management interface.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
  end
  
  scenario 'An artisan can visit the management interface' do
    # When I visit the management interface,
    visit management_interface
    
    # Then I should see the management interface.
    page.should have_content 'Manage'
  end
end