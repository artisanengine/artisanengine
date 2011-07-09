Factory.define :good do |g|
  g.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  g.name        { Faker::Address.country + " " + Faker::Internet.domain_word.capitalize }
end

Factory.define :good_with_size_and_color, parent: :good do |g|
  g.after_create do |g|
    # Change first option,
    g.options.first.update_attributes( name: 'Size', default_value: 'Small' )
    
    # Add second option.
    g.options << Option.spawn( name: 'Color', default_value: 'Blue' )
    
    g.save
  end
end

Factory.define :good_with_5_options, parent: :good do |g|
  g.after_create do |g|
    4.times { g.options << Option.spawn }
  end
end

Factory.define :good_with_3_variants, parent: :good do |g|
  g.after_create do |g|
    g.variants << Variant.spawn
    g.variants << Variant.spawn
  end
end

Factory.define :good_with_three_options_and_variants, parent: :good do |g|
  g.after_create do |g|
    g.options.first.update_attributes( name: 'Size', default_value: 'Small' )
    g.variants.first.update_attributes( option_value_1: 'Small' )
    
    g.options << Option.spawn( name: 'Color',    default_value: 'Blue' )
    g.options << Option.spawn( name: 'Material', default_value: 'Cloth' )
    
    g.variants << Variant.spawn( option_value_1: 'Medium', option_value_2: 'Blue', option_value_3: 'Cloth' )
    g.variants << Variant.spawn( option_value_1: 'Large',  option_value_2: 'Red',  option_value_3: 'Cloth' )
  end
end