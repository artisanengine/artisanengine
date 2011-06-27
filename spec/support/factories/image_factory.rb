require "#{ Rails.root }/spec/support/images/image_paths"

Factory.define :image do |i|
  i.frame       { Frame.find_or_create_by_domain( 'example.com', name: 'Example Frame' ) }
  i.image       test_image
end