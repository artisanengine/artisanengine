require 'acceptance/acceptance_helper'

feature 'Create a Promotion', %q{
  In order to encourage visitors to buy things
  As an artisan
  I want to create a promotion.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I am on the New Promotion page,
    visit new_promotion_page
  end
  
  scenario "An artisan can create a percent-off entire order promotion with valid attributes" do
    # When I fill in valid information for the promotion,
    fill_in 'Promotional Code', with: 'TENPERCENTOFF'
    
    # And I fill in Discount Amount with 10
    fill_in 'Discount Amount', with: '10'
    
    # And I select Percent Off from Discount Type
    select 'Percent Off', from: 'Discount Type'
    
    # And I select Entire Order from Discount Target
    select 'Entire Order', form: 'Discount Target'
    
    # And I click Create Promotion,
    click_button 'Create Promotion'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should my promotion's code.
    page.should have_content 'TENPERCENTOFF'
  end
  
  scenario "An artisan cannot create a promotion with invalid attributes" do
    # When I fill in invalid information for the promotion,
    fill_in 'Promotional Code', with: ''
    
    # And I click Create Promotion,
    click_button 'Create Promotion'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And there should be no promotions.
    Promotion.count.should be 0
  end
end