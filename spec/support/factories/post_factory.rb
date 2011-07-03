Factory.define :post do |p|
  p.association :blog
  
  p.title       { Faker::Company.catch_phrase }
end