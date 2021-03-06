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
  shipping = options[ :shipping ] || '6.23'
  tax      = options[ :tax ]      || '9.12'
  
  gross          = options[ :gross ] || Order.last.adjusted_total
  adjusted_gross = gross + tax.to_money + shipping.to_money
  
  page.driver.post '/ipns', txn_id:         options[ :ref ]      || 'TESTTRANS',
                            invoice:        options[ :order ]    || Order.last.id,
                            payment_status: options[ :status ]   || 'Completed',
                            mc_fee:         options[ :fee ]      || '2.28',
                            mc_gross:       adjusted_gross,
                            mc_shipping:    shipping,
                            tax:            tax,
                            test:           options[ :test_ipn ] || '1'
end

def checkout( options = {} )
  email = options[ :as ] || 'billy.thekid@varmints.net'
  
  visit order_page
  click_link 'Checkout'
  fill_in_valid_checkout_information( options )
  click_button 'Pay Securely with PayPal'
end

def fill_in_valid_checkout_information( options = {} )
  email = options[ :as ] || 'billy.thekid@varmints.net'
  
  fill_in 'E-Mail',      with: email
  
  fill_in 'First Name',  with: 'Billy'
  fill_in 'Last Name',   with: 'the Kid'
  fill_in 'Address 1',   with: '1110 Gorgas Ave.'
  fill_in 'Address 2',   with: 'Suite 100'
  fill_in 'City',        with: 'San Francisco'
  fill_in 'Postal Code', with: '92531'
  
  select  'United States', from: 'Country'
  
  if options[ :js ]
    select 'California', from: 'State/Province'
  else
    fill_in 'State/Province', with: 'CA'
  end
end