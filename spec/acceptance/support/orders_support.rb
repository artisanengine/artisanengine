# ------------------------------------------------------------------
# Paths

def order_page
  '/order'
end

# ------------------------------------------------------------------
# Actions

def add_to_order( good_name )
  visit good_page_for good_name
  click_button 'Add to Order'
end