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
# Test Frame Management

def find_or_create_frame( domain )
  Frame.find_or_create_by_domain( domain, name: 'Example Frame' )
end

def browse_frame( domain )  
  # Find or create a frame matching the given domain.
  find_or_create_frame( domain )
  
  # Force the frame.
  ENV[ "FORCE_FRAME" ] = domain
  
  # Since we're simulating visiting a different domain, also simulate clearing
  # the session since the browser would do that automatically.
  Capybara.reset_sessions!
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