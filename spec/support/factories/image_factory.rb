Factory.define :image do |i|
  i.frame       { Frame.find_or_create_by_domain( 'example.com', name: 'Example Frame' ) }
  i.image       File.new( File.expand_path( '../../../acceptance/support/images/anaura_bay.jpg', __FILE__ ) )
end