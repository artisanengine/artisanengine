# ------------------------------------------------------------------
# Paths

def new_image_page
  '/images/new'
end

# ------------------------------------------------------------------
# Actions

# ------------------------------------------------------------------
# Test Image Helpers

def test_image
  File.expand_path( '../images/anaura_bay.jpg', __FILE__ )
end