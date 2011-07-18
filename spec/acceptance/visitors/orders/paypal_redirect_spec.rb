require 'acceptance/acceptance_helper'

feature "Redirect to PayPal", %q{
  In order to complete my order
  As a visitor
  I want to be redirected to PayPal.
} do
  
  background do
    # Given there is a good,
    Good.generate name: 'Bandana'

    # And I have ordered the good,
    add_to_order 'Bandana'
    
    # And I fill in valid information and click Checkout,
    checkout js: true
  end

  scenario "I am auto-redirected to PayPal if JavaScript is enabled", js: true, remote: true do
    # Then I should be redirected to PayPal.
    sleep 1 and page.current_url.should =~ /paypal/
  end
end