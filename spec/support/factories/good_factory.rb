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