# ------------------------------------------------------------------
# Test Frame Management

def browse_frame( domain )  
  # Find or create a frame matching the given domain.
  use_frame( domain )
  
  # Tell Capybara to direct requests to the new domain.
  Capybara.app_host = "http://#{ domain }:7357"
end

# Find or create a frame matching the given domain.
def use_frame( domain )
  Frame.find_or_create_by_domain( domain, name: 'Test Frame' )
end

# ------------------------------------------------------------------
# Paths

def new_frame_page
  '/frames/new'
end

# ------------------------------------------------------------------
# Actions

def fill_in_frame_information( options = {} )
  # Options:
  name   = options[ :name ]   ||= 'Example Frame'
  domain = options[ :domain ] ||= 'example.com'
  
  # Action:
  fill_in 'Name',   with: name
  fill_in 'Domain', with: domain
end

# ------------------------------------------------------------------
# Test Theme Management

def create_example_theme_layout_with_content( content )
  # Create the theme directory.
  example_theme_dir = "#{ Rails.root }/app/themes/example.com/views/layouts"
  FileUtils.mkdir_p( example_theme_dir )
  
  # Create the layout and fill it with content.
  f = File.open( example_theme_dir + "/application.html.haml", 'w' ) 
  f.write content
  f.close
end

def destroy_test_layout
  # Destroy the theme directory.
  FileUtils.rm_r( "#{ Rails.root }/app/themes/example.com" )
end