require 'acceptance/acceptance_helper'

feature 'Delete a Good', %q{
  In order to cull the weak goods
  As an artisan
  I want to delete a good.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good,
    Good.generate name: 'Freeze Ray'
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end
  
  scenario "An artisan can delete a good" do
    # When I click the Delete button,
    click_button 'Delete This Good'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should not see my good.
    page.should have_no_selector '.good', text: 'Freeze Ray'
  end
end