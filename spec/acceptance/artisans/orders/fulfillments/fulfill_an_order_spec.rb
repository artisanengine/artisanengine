require 'acceptance/acceptance_helper'

feature "Fulfill an Order", %q{
  In order to manage shipping and other fulfillment logistics for my orders
  As an artisan
  I want to fulfill an order.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And there is a paid order,
    order = Factory :purchased_order

    # And I am on the order's detail page,
    visit order_details_page_for order.id_in_frame
  end
  
  scenario "An artisan can fully fulfill an order" do
    # When I click the Fulfill link,
    click_link 'Fulfill This Order'
    
    # And I fill in my shipping method, tracking number, and cost and click Fulfill,
    fill_in 'Shipping Method', with: 'UPS 3-Day'
    fill_in 'Cost',            with: 25
    fill_in 'Tracking',        with: 'ABC123'
    
    click_button 'Fulfill'
    
    # Then I should see my order fulfilled.
    page.should have_content 'Fulfilled'
  end
end