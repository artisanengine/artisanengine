Factory.define :engineer do |e|
  e.email                 { Faker::Internet.email }
  e.password              'password'
  e.password_confirmation { |u| u.password }
end