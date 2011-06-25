Factory.define :frame do |f|
  f.name   { Faker::Internet.domain_word.capitalize }
  f.domain { Faker::Internet.domain_name }
end