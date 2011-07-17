Factory.define :patron do |p|
  p.frame      { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  p.first_name { Faker::Name.first_name }
  p.last_name  { Faker::Name.last_name }
  p.email      { Faker::Internet.email }
end