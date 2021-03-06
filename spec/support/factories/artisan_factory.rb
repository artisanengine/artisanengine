Factory.define :artisan do |u|
  u.frame                 { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  
  u.first_name            { Faker::Name.first_name }
  u.last_name             { Faker::Name.last_name }
  u.email                 { Faker::Internet.email }
  u.password              'password'
  u.password_confirmation { |u| u.password }
end