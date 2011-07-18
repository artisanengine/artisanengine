require 'acceptance/acceptance_helper'

feature "Fulfillment E-Mail", %q{
  In order to notify my patrons when their orders ship
  As an artisan
  I want a fulfillment to trigger an confirmation E-Mail.
} do
  
  background do
    # Clear any existing deliveries.
    ActionMailer::Base.deliveries.clear
    
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And there is a paid order,
    @order = Factory :purchased_order

    # And I am on the order's detail page,
    visit order_details_page_for @order.id_in_frame
    
    # And I click the Fulfill link,
    click_link 'Fulfill This Order'
    
    # And I fill in my shipping method, tracking number, and cost,
    fill_in 'Shipping Method', with: 'UPS 3-Day'
    fill_in 'Cost',            with: 25
    fill_in 'Tracking',        with: 'ABC123'
    
    # And I check 'Send Confirmation to Patron'
    check 'Send Confirmation to Patron'
    
    # And I click Fulfill
    click_button 'Fulfill'
  end
  
  scenario "A patron receives an E-Mail when an order is fulfilled" do
    # Then the patron should receive an E-Mail.
    ActionMailer::Base.deliveries.should_not be_empty

    email = ActionMailer::Base.deliveries.first
    
    email.from.should    include 'noreply@ae.test'
    email.to.should      include @order.patron.email
    email.subject.should == 'Your order has shipped!'
    
    email.encoded.should =~ /The following items from your order have shipped via UPS 3-Day/
    
    for item in @order.line_items
      email.encoded.should include item.name
    end
    
    email.encoded.should =~ /Your tracking number for these items is: ABC123/
    email.encoded.should =~ /Test Frame/
  end
end