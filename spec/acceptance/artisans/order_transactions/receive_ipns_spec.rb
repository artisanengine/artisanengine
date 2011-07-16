require 'acceptance/acceptance_helper'

feature "Receive PayPal IPNs", %q{
  In order to be notified when patrons pay using PayPal Website Payments Standard
  As an artisan
  I want my order to update when my site receives an Instant Payment Notification.
} do
  
  background do
    # Given I have a pending order,
    Factory :pending_order
    
    # And I am signed in as an artisan,
    sign_in_as_artisan
  end
  
  scenario "The application can properly process a valid IPN" do
    # When my site receives an IPN,
    simulate_ipn
    
    # And I visit the manage orders page,
    visit '/manage/orders'
    
    # Then I should see a Purchased order.
    page.should have_selector '.order .status', text: 'Purchased'
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