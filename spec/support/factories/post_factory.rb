Factory.define :post do |p|
  p.association :blog
  
  p.title       { Faker::Company.catch_phrase }
  p.content     { Faker::Lorem.paragraphs( 3 ).join( ' ' ) }
end