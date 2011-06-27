def test_image_path
  File.expand_path( '../anaura_bay.jpg', __FILE__ )
end

def test_image
  File.new( test_image_path )
end