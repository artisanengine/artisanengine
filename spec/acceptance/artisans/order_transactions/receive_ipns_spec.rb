require 'acceptance/acceptance_helper'

feature "Receive PayPal IPNs", %q{
  In order to be notified when patrons pay using PayPal Website Payments Standard
  As an artisan
  I want my order to update when my site receives an Instant Payment Notification.
} do
  
  background do
    # Given I have a pending order,
    @order = Factory :pending_order
    
    # And I am signed in as an artisan,
    sign_in_as_artisan
  end
  
  scenario "The application can properly process a valid IPN" do
    # When my site receives a valid IPN,
    simulate_ipn tax: 0, shipping: 0, gross: @order.total
    
    # And I visit the manage orders page,
    visit '/manage/orders'
    
    # Then I should see a Purchased order.
    page.should have_selector '.order .status', text: 'Purchased'
    
    # And when I visit the order details page,
    within '.order' do
      click_link 'Details'
    end
    
    # Then I should see a successful transaction.
    within '.order_transaction' do
      page.should have_content 'PayPal WPS'
      page.should have_content 'Success'
    end
  end
    
  scenario "The application can properly process an invalid IPN" do
    # When my site receives an invalid IPN,
    simulate_ipn status: 'Incomplete'

    # And I visit the manage orders page,
    visit '/manage/orders'
    
    # Then I should see a Failed order.
    page.should have_selector '.order .status', text: 'Failed'
  end
end