# ------------------------------------------------------------------
# Test Theme Management

def create_test_theme_layout_with_content( content )
  # Create the theme directory.
  FileUtils.mkdir_p( theme_dir + '/layouts' )
  
  # Create the layout and fill it with content.
  f = File.open( theme_dir + "/layouts/application.html.haml", 'w' ) 
  f.write content
  f.close
end

def destroy_test_layout
  # Destroy the theme directory.
  FileUtils.rm_r( theme_dir ) if File.exists?( theme_dir )
end

def theme_dir
  "#{ Rails.root }/app/themes/ae"
end