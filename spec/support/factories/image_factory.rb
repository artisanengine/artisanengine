require "#{ Rails.root }/spec/support/images/image_paths"

Factory.define :image do |i|
  i.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  i.image       { test_image }
end

Factory.define :anaura_bay_image, parent: :image do |i|
  i.image       { anaura_bay_image }
end