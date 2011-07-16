require 'acceptance/acceptance_helper'

feature "Checkout an Order", %q{
  In order to begin the purchase process
  As a visitor
  I want to check out.
} do
  
  background do
    # Given a good exists,
    Good.generate name: 'Gnarlystick'
    
    # And I have added the good to my order,
    add_to_order 'Gnarlystick'
    
    # And I have clicked the 'Checkout' link,
    click_link 'Checkout'
  end
  
  scenario "A visitor can check out an order with valid information" do
    # When I fill in valid checkout information,
    fill_in 'E-Mail', with: 'randy@skywalkersound.com'
    check 'Send me news and special offers from Test Frame'
    
    within '#shipping_address' do
      fill_in 'First Name',  with: 'Randy'
      fill_in 'Last Name',   with: 'Thom'
      fill_in 'Address 1',   with: '1110 Gorgas Ave.'
      fill_in 'Address 2',   with: 'Suite 100'
      fill_in 'City',        with: 'San Francisco'
      fill_in 'Postal Code', with: '92531'
      
      select  'United States',  from: 'Country'
      fill_in 'State/Province', with: 'CA'
      
      uncheck 'My billing address is the same as my shipping address.'
    end
    
    within '#billing_address' do
      fill_in 'First Name',  with: 'George'
      fill_in 'Last Name',   with: 'Lucas'
      fill_in 'Address 1',   with: 'LucasArts Space Station'
      fill_in 'Address 2',   with: 'Penthouse Suite'
      fill_in 'City',        with: 'West Pod'
      fill_in 'Postal Code', with: 'Orbital PE3'
      
      select  'United States',  from: 'Country'
      fill_in 'State/Province', with: 'New Mexico'
    end
    
    # And I click Pay with PayPal,
    click_button 'Pay with PayPal'
    
    # Then there should be one pending order,
    Order.count.should == 1
    
    order = Order.first
    order.status.should == 'pending'
    
    # And there should be two addresses,
    Address.count.should == 2
    order.shipping_address.should_not be_nil
    order.billing_address.should_not be_nil
    
    # And there should be one new patron named George Lucas.
    Patron.count.should == 1
    order.patron.should_not be_nil
    order.patron.first_name.should == "George"
  end
end