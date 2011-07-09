Factory.define :option do |o|
  o.association     :good
  
  o.name            { Faker::Lorem.words( 1 ).first.capitalize }
  o.default_value   { Faker::Lorem.words( 1 ).first.capitalize }
end