Factory.define :page do |f|
  f.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  
  f.title       { Faker::Company.catch_phrase }
end