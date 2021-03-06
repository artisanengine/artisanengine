# ------------------------------------------------------------------
# Orders

Factory.define :order do |o|
  o.frame { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
end

Factory.define :pending_order, parent: :order do |o|
  o.after_create do |o|
    3.times { LineItem.generate order: o, quantity: rand( 6 ) }
    
    o.email            = Faker::Internet.email
    o.shipping_address = Address.generate
    o.billing_address  = Address.generate
    o.checkout!
  end
end

Factory.define :purchased_order, parent: :pending_order do |o|
  o.after_create do |o| 
    o.order_transactions << Factory( :paypal_transaction, order: o )
    o.purchase!
  end
end

Factory.define :failed_order, parent: :pending_order do |o|
  o.after_create { |o| o.fail! }
end

# ------------------------------------------------------------------
# Line Items

Factory.define :line_item do |l|
  l.association :order
  l.association :variant
end

# ------------------------------------------------------------------
# Transactions

Factory.define :order_transaction do |o|
  o.association :order
  o.success     true
end


Factory.define :paypal_transaction, parent: :order_transaction do |o|
  o.reference         "TESTTRANS"
  o.action            "purchase"
  o.params            { { param1: "param", param2: "param" } }
  o.payment_service   "PayPal WPS"
  
  o.after_create do |o|
    DollarAdjustment.generate( adjustable: o.order, message: "PayPal-Calculated Tax",      basis: 3.5 )
    DollarAdjustment.generate( adjustable: o.order, message: "PayPal-Calculated Shipping", basis: 5 )
    DollarAdjustment.generate( adjustable: o.order, message: "PayPal Transaction Fee",     basis: -1.26 )
    
    o.update_attributes amount: o.order.adjusted_total
  end
end

# ------------------------------------------------------------------
# Adjustments

Factory.define :dollar_adjustment do |a|
  a.adjustable        { Factory :order }
  a.basis             { rand( 50 ) + 1 }
end

# ------------------------------------------------------------------
# Fulfillments

Factory.define :fulfillment do |f|
  f.association       :order
  f.shipping_method   'UPS 3-Day Select'
  
  f.after_build do |f|
    unless f.line_item_ids.any?
      line_item = LineItem.generate( order: f.order )
      f.line_items << line_item
    end
  end
end