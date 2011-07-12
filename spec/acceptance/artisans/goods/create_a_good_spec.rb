require 'acceptance/acceptance_helper'

feature 'Create a Good', %q{
  In order to populate my catalog with goods for visitors to buy
  As an artisan
  I want to create a good.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I am on the New Good page,
    visit new_good_page
  end
  
  scenario "An artisan can create a good with valid attributes" do
    # When I fill in valid information for the good,
    fill_in 'Name', with: 'Freeze Ray'
    
    # And I click Create Good,
    click_button 'Create Good'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my good and my good's title.
    page.should have_selector '#good', text: 'Freeze Ray'
  end
  
  scenario "An artisan cannot create a good with invalid attributes" do
    # When I fill in invalid information for the good,
    fill_in 'Name', with: ''
    
    # And I click Create Good,
    click_button 'Create Good'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And there should be no goods.
    Good.count.should be 0
  end
end