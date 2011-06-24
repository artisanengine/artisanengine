# ------------------------------------------------------------------
# Paths

def new_frame_page
  '/frames/new'
end

# ------------------------------------------------------------------
# Actions

def create_frame( options = {} )
  # Options:
  name   = options[ :name ]   ||= 'Example Frame'
  domain = options[ :domain ] ||= 'example.com'
  
  # Action:
  visit new_frame_page
  
  fill_in 'Name',   with: name
  fill_in 'Domain', with: domain

  click_button 'Create Frame'
end

# ------------------------------------------------------------------
# Test Frame Management

def browse_frame( domain, options = {} )
  # Options
  name = options[ :name ] || 'Example Frame'
  
  # Find or create a frame matching the given domain.
  frame = Frame.find_by_domain( domain ) || Fabricate( :frame, name: name,
                                                               domain: domain )
  
  # Force the frame.                  
  ENV[ "FORCE_FRAME" ] = frame.domain
end

# Helper method to allow other integration methods to force the frame.
def can_force_frame( options )
  browse_frame options[ :in_frame ] if options[ :in_frame ]
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