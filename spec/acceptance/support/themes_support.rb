# ------------------------------------------------------------------
# Test Theme Management

# Create a theme directory for the test frame.
def create_test_theme_layout_with_content( content )
  # Create the theme directory.
  FileUtils.mkdir_p( theme_dir + '/layouts' )
  
  # Create the layout and fill it with content.
  f = File.open( theme_dir + "/layouts/visit.html.haml", 'w' ) 
  f.write content
  f.close
end

# Destroy the theme directory.
def destroy_test_layout
  FileUtils.rm_r( theme_dir ) if File.exists?( theme_dir )
end

def theme_dir
  "#{ Rails.root }/app/themes/ae"
end