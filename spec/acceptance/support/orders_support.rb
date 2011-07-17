# ------------------------------------------------------------------
# Paths

def order_page
  '/order'
end

def manage_orders_page
  '/manage/orders'
end

def order_details_page_for( id_in_frame )
  "/manage/orders/#{ id_in_frame }"
end

# ------------------------------------------------------------------
# Actions

def add_to_order( good_name )
  visit good_page_for good_name
  click_button 'Add to Order'
end

def simulate_ipn( options = {} )
  page.driver.post '/ipns', txn_id:         options[ :ref ]      || 'TESTTRANS',
                            invoice:        options[ :order ]    || Order.last.id,
                            payment_status: options[ :status ]   || 'Completed',
                            mc_fee:         options[ :fee ]      || '2.28',
                            mc_gross:       options[ :gross ]    || Order.last.total,
                            mc_shipping:    options[ :shipping ] || '6.23',
                            tax:            options[ :tax ]      || '9.12',
                            test:           options[ :test_ipn ] || '1'
end

def checkout( options = {} )
  email = options[ :as ] || 'billy.thekid@varmints.net'
  
  visit order_page
  click_link 'Checkout'
  fill_in_valid_checkout_information( email: email )
  click_button 'Pay with PayPal'
end

def fill_in_valid_checkout_information( options = {} )
  email = options[ :email ] || 'billy.thekid@varmints.net'
  
  fill_in 'E-Mail',      with: email
  
  fill_in 'First Name',  with: 'Billy'
  fill_in 'Last Name',   with: 'the Kid'
  fill_in 'Address 1',   with: '1110 Gorgas Ave.'
  fill_in 'Address 2',   with: 'Suite 100'
  fill_in 'City',        with: 'San Francisco'
  fill_in 'Postal Code', with: '92531'
  
  select  'United States',  from: 'Country'
  fill_in 'State/Province', with: 'CA'
end