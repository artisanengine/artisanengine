Factory.define :order do |o|
  o.frame { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
end

Factory.define :pending_order, parent: :order do |o|
  o.after_create do |o|
    3.times { LineItem.generate order: o }
    
    o.email            = Faker::Internet.email
    o.shipping_address = Address.generate
    o.billing_address  = Address.generate
    o.checkout!
  end
end

Factory.define :line_item do |l|
  l.association :order
  l.association :variant
end

Factory.define :order_transaction do |o|
  o.association :order
  o.success     true
end