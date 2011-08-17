require 'acceptance/acceptance_helper'

feature 'Apply a Promotion', %q{
  In order to get discounts
  As a visitor
  I want to apply a promotional code.
} do
  
  background do
    # Given a test artisan has created a promotional code,
    Factory :ten_percent_off_promotion, promotional_code: "TENPERCENTOFF"
    
    # And a good ...
    Good.generate name: 'Sweet Muffins' # Default price of 100.

    # And I am browsing the test frame,
    browse_frame
    
    # And I have added the good to my order,
    add_to_order 'Sweet Muffins'
    
    # And I am on the order page,
    visit order_page
  end
  
  scenario "A visitor can apply a valid promotional code to an order" do
    # When I fill in Promotional Code with TENPERCENTOFF,
    fill_in 'Promotional Code', with: 'TENPERCENTOFF'
    
    # And I click Apply,
    click_button 'Apply'
    
    # Then I should see the code,
    page.should have_content 'TENPERCENTOFF'
    
    # And I should see the modified order total.
    page.should have_content '$90.00'
  end
end