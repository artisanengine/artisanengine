Factory.define :good do |g|
  g.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  g.name        { Faker::Address.country + " " + Faker::Company.name }
  g.description { Faker::Lorem.paragraphs( 3 ).join( ' ' ) }
end