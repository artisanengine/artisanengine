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