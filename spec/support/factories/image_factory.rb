require "#{ Rails.root }/spec/support/images/image_paths"

Factory.define :image do |i|
  i.frame       { Frame.find_or_create_by_domain( 'ae.test', name: 'Test Frame' ) }
  i.image       { test_image }
end