Factory.define :patron do |p|
  p.first_name { Faker::Name.first_name }
  p.last_name  { Faker::Name.last_name }
  p.email      { Faker::Internet.email }
end