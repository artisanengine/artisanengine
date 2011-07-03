Factory.define :variant do |v|
  v.association :good
  
  v.after_build do |v|
    v.required_number_of_options.times do |time|
      eval( "v.option_value_#{ time + 1 } = '#{ Faker::Lorem.words( 1 ).first }'")
      v.save
    end
  end
end