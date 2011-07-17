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
  
  scenario "A visitor cannot check out an order with invalid information" do
    # When I fill in invalid checkout information,
    fill_in 'E-Mail', with: ''
    check 'Send me news and special offers from Test Frame'
    
    # And I click Pay with PayPal,
    click_button 'Pay with PayPal'
    
    # Then I should see an error,
    page.should have_selector '.error'
    
    # And the order should still be new.
    Order.last.should be_new
  end
  
  scenario "Duplicate addresses are not created and addresses are assigned to the new patron" do
    # When I fill in valid checkout information,
    fill_in 'E-Mail', with: 'randy@skywalkersound.com'
    check 'Send me news and special offers from Test Frame'
    
    # And I fill in one address and check "My billing address is the same as my shipping address"
    within '#shipping_address' do
      fill_in 'First Name',  with: 'Randy'
      fill_in 'Last Name',   with: 'Thom'
      fill_in 'Address 1',   with: '1110 Gorgas Ave.'
      fill_in 'Address 2',   with: 'Suite 100'
      fill_in 'City',        with: 'San Francisco'
      fill_in 'Postal Code', with: '92531'
      
      select  'United States',  from: 'Country'
      fill_in 'State/Province', with: 'CA'
      
      check 'My billing address is the same as my shipping address.'
    end
    
    # And I click Pay with PayPal,
    click_button 'Pay with PayPal'
    
    # Then there should be 1 address.
    Address.count.should == 1
    
    # And the order's billing and shipping address should be the same,
    order = Order.last
    order.billing_address.should == order.shipping_address
    
    # And they should both belong to the order's patron.
    patron = order.patron
    patron.addresses.should include order.shipping_address
    patron.addresses.should include order.billing_address
  end
  
  scenario "Auto-updating state select", js: true do
    # Within shipping address,
    within '#shipping_address' do
      # When I select United States,
      select 'United States', from: 'Country'
      
      # Then I should see a select list of states.
      within 'select#order_shipping_address_province' do
        page.should have_selector 'option', text: 'Alabama'
      end
      
      # When I select Canada,
      select 'Canada', from: 'Country'
      sleep 0.2
      
      # Then I should see a select list of provinces.
      within 'select#order_shipping_address_province' do
        page.should have_selector 'option', text: 'Alberta'
      end
      
      # When I select Madagascar,
      select 'Madagascar', from: 'Country'
      sleep 0.2
      
      # Then I should not see a select list.
      page.should have_no_selector 'select#order_shipping_address_province', visible: true
    end
    
    # Within billing address,
    within '#billing_address' do
      # When I select United States,
      select 'United States', from: 'Country'
      
      # Then I should see a select list of states.
      within 'select#order_billing_address_province' do
        page.should have_selector 'option', text: 'Alabama'
      end
      
      # When I select Canada,
      select 'Canada', from: 'Country'
      sleep 0.2
      
      # Then I should see a select list of provinces.
      within 'select#order_billing_address_province' do
        page.should have_selector 'option', text: 'Alberta'
      end
      
      # When I select Madagascar,
      select 'Madagascar', from: 'Country'
      sleep 0.2
      
      # Then I should not see a select list.
      page.should have_no_selector 'select#order_billing_address_province', visible: true
    end
  end
    
end