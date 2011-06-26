Factory.define :user do |u|
  u.association :frame
  
  u.first_name            { Faker::Name.first_name }
  u.last_name             { Faker::Name.last_name }
  u.email                 { Faker::Internet.email }
  u.password              'password'
  u.password_confirmation { |u| u.password }
end

Factory.define :artisan, :parent => :user do |a|
  a.role                  'Artisan'
end

Factory.define :engineer, :parent => :user do |e|
  e.role                  'Engineer'
end