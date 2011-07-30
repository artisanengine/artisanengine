require 'acceptance/acceptance_helper'

feature 'Update a Good', %q{
  In order to list goods without selling them
  As an artisan
  I want to mark a good as unavailable for sale.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I am on the New Good page,
    visit new_good_page
  end
  
  scenario "An artisan can mark a good as unavailable for sale" do
    # When I fill in valid information for the good,
    fill_in 'Name', with: 'Freeze Ray'
    
    # And I uncheck 'This good is available for sale.'
    uncheck 'This good is available for sale.'
    
    # And I click Create Good,
    click_button 'Create Good'
        
    # And I go to the show good page for the good,
    visit good_page_for 'Freeze Ray'
    
    # Then I should see "This item is currently unavailable."
    page.should have_content 'This item is currently unavailable.'
    
    # And I should not see an Add to Order button.
    page.should have_no_selector 'input[type=submit]'
  end
end