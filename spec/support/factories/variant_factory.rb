Factory.define :variant do |v|
  v.association :good
  v.price       { rand( 5000 ) + 1 }
  
  v.after_build do |v|
    v.required_number_of_options.times do |time|
      eval( "v.option_value_#{ time + 1 } = '#{ Faker::Lorem.words( 1 ).first }'") unless eval( "v.option_value_#{ time + 1 }" )
      v.save
    end
  end
end