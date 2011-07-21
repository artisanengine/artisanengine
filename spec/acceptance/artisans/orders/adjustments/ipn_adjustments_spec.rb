require 'acceptance/acceptance_helper'

feature "Order Adjustments from IPNs", %q{
  In order to keep track of tax and shipping charges from PayPal WPS
  As an artisan
  I want order adjustments to be created when I receive an IPN.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have a pending order,
    @order = Factory :pending_order
    
    # And I receive an IPN with tax and shipping costs,
    simulate_ipn shipping: 25, tax: 5, fee: 2, order: @order.id
  end
  
  scenario "IPNs create order adjustments from tax, fee, shipping" do
    # When I visit the order details page for the order,
    visit order_details_page_for @order.id_in_frame
    
    # Then I should see shipping costs for $25.00,
    within '.adjustment', text: 'PayPal-Calculated Shipping' do
      page.should have_content "$25.00"
    end
    
    # And I should see tax of $5.00.
    within '.adjustment', text: 'PayPal-Calculated Tax' do
      page.should have_content "$5.00"
    end
    
    # And I should see fee of $2.00.
    within '.adjustment', text: 'PayPal Transaction Fee' do
      page.should have_content "$-2.00"
    end
  end
end