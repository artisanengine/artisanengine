Factory.define :promotion do |p|
  p.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
end

Factory.define :ten_percent_off_promotion, parent: :promotion do |p|
  p.promotional_code    "TENPERCENTOFF"
  p.discount_amount     10
  p.discount_type       "Percent Off"
  p.discount_target     "Entire Order"
end