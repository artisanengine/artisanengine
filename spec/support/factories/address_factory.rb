Factory.define :address do |a|
  a.first_name  { Faker::Name.first_name }
  a.last_name   { Faker::Name.last_name }
  a.address_1   { Faker::Address.street_address }
  a.city        { Faker::Address.city }
  a.postal_code { Faker::Address.zip }
  a.country     { Faker::Address.country }
end