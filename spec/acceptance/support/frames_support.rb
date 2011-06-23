# ------------------------------------------------------------------
# Paths

def new_frame_page
  '/engineer/frames/new'
end

# ------------------------------------------------------------------
# Actions

def create_frame( options = {} )
  # Options:
  name   = options[ :name ]   ||= 'Haus Leather'
  domain = options[ :domain ] ||= 'hausleather'
  
  # Action:
  visit new_frame_page
  
  fill_in 'Name',   with: name
  fill_in 'Domain', with: domain

  click_button 'Create Frame'
end

def create_example_theme_layout_with_content( content )
  # Create the theme directory.
  example_theme_dir = "#{ Rails.root }/app/themes/example/views/layouts"
  FileUtils.mkdir_p( example_theme_dir )
  
  # Create the layout and fill it with content.
  f = File.open( example_theme_dir + "/application.html.haml", 'w' ) 
  f.write content
  f.close
end

def destroy_test_layout
  # Destroy the theme directory.
  FileUtils.rm_r( "#{ Rails.root }/app/themes/example" )
end