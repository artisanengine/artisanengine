Fabricator :frame do
  name   { Faker::Internet.domain_word.capitalize }
  domain { Faker::Internet.domain_name }
end