Factory.define :page do |f|
  f.frame       { Frame.find_or_create_by_domain( 'example.com', name: 'Example Frame' ) }
  
  f.title       { Faker::Company.catch_phrase }
  f.content     { Faker::Lorem.paragraphs( 3 ) }
end