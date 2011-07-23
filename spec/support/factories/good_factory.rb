Factory.define :good do |g|
  g.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  g.name        { Faker::Address.country + " " + Faker::Internet.domain_word.capitalize }
  g.description { two_paragraphs }
end

Factory.define :good_with_size_and_color, parent: :good do |g|
  g.after_create do |g|
    # Change first option,
    g.options.first.update_attributes( name: 'Size', default_value: 'Small' )
    
    # Add second option.
    Option.generate( good: g, name: 'Color', default_value: 'Blue' )
    
    g.save
  end
end

Factory.define :good_with_5_options, parent: :good do |g|
  g.after_create do |g|
    4.times { Option.generate good: g }
  end
end

Factory.define :good_with_3_variants, parent: :good do |g|
  g.after_create do |g|
    Variant.generate good: g
    Variant.generate good: g
  end
end

Factory.define :good_with_three_options_and_variants, parent: :good do |g|
  g.after_create do |g|
    g.options.first.update_attributes!( name: 'Size', default_value: 'Small' )
    g.variants.first.update_attributes!( option_value_1: 'Small' )
    
    Option.generate( good: g, name: 'Color',    default_value: 'Blue' )
    Option.generate( good: g, name: 'Material', default_value: 'Cloth' )
    
    Variant.generate( good: g, option_value_1: 'Medium', option_value_2: 'Blue', option_value_3: 'Cloth' )
    Variant.generate( good: g, option_value_1: 'Large',  option_value_2: 'Red',  option_value_3: 'Cloth' )
  end
end

def two_paragraphs
  %Q{#{ Faker::Lorem.paragraph }

#{ Faker::Lorem.paragraph } }
end