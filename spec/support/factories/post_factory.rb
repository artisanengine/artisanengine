Factory.define :post do |p|
  p.association :blog
  
  p.title         { Faker::Company.catch_phrase }
  p.published_on  { Date.new( 2011 ) }
end

Factory.define :loaded_post, parent: :post do |p|
  p.content     { three_paragraphs }
end

def three_paragraphs
  %Q{#{ Faker::Lorem.paragraph }

#{ Faker::Lorem.paragraph }

#{ Faker::Lorem.paragraph } }
end