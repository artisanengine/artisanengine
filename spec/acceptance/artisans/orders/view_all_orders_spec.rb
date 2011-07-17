require 'acceptance/acceptance_helper'

feature "View My Orders", %q{
  In order to view and manage my orders
  As an artisan
  I want to see all my orders.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # Given I have three pending orders,
    3.times { Factory :order }
    3.times { Factory :pending_order }
  
    # And I am on the manage orders page,
    visit manage_orders_page
  end
  
  scenario "An artisan can see all her orders (except new orders)" do
    # Then I should see three pending orders,
    page.should have_selector '.order .status', text: 'Pending', count: 3
    
    # And I should not see any new orders.
    page.should have_no_selector '.order .status', text: 'New'
  end
end