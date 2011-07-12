Factory.define :page do |p|
  p.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  
  p.title       { Faker::Company.catch_phrase }
end

Factory.define :loaded_page, parent: :page do |p|
  p.content { three_paragraphs }
end

def three_paragraphs
  %Q{#{ Faker::Lorem.paragraph }

#{ Faker::Lorem.paragraph }

#{ Faker::Lorem.paragraph } }
end