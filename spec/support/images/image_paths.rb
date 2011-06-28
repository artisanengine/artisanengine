# An array of pathnames to test images.
def test_image_paths
  images = [ "anaura_bay.jpg", "GuArDiAnS.png", "kode.gif",
             "spartan.jpg", "spring-fever.jpg", "TheEdge2.jpg" ]
             
  images.map!{ |image| File.expand_path( "../#{ image }", __FILE__ ) }
end

# Random image pathname.
def test_image_path
  test_image_paths.sample
end

# Random image file.
def test_image
  File.new( test_image_paths.sample )
end

# The Anaura Bay image path.
def anaura_bay_image_path
  File.expand_path( "../anaura_bay.jpg", __FILE__ )
end