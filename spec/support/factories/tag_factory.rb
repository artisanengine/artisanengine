Factory.define :tag do |t|
  t.frame   { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  t.name    { Faker::Lorem.words( 1 ).first }
end