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

Factory.define :line_item do |l|
  l.association :order
  l.association :variant
end

Factory.define :order_transaction do |o|
  o.association :order
  o.success     true
end

Factory.define :paypal_transaction, parent: :order_transaction do |o|
  o.amount            { |o| o.order.line_total }
  o.reference         "TESTTRANS"
  o.action            "purchase"
  o.params            { { param1: "param", param2: "param" } }
  o.payment_service   "PayPal WPS"
end

Factory.define :order_adjustment do |a|
  a.association       :order
  a.message           "Test Message"
end