# ------------------------------------------------------------------
# Test Frame Management

def browse_frame( domain = 'ae.test' )  
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
  '/develop/frames/new'
end