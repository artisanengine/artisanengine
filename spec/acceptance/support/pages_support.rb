# ------------------------------------------------------------------
# Paths

def new_page_page
  '/pages/new'
end

def visit_page( title )
  page = Page.find_by_title( title )
  visit "/pages/#{ page.id }"
end

# ------------------------------------------------------------------
# Actions

def create_page( options = {} )
  can_force_frame( options )
  
  # Options
  title   = options[ :title ]   || 'About Me'
  content = options[ :content ] || 'Some things about me.'
  
  # Action
  visit new_page_page
  
  fill_in 'Title',   with: title
  fill_in 'Content', with: content

  click_button 'Create Page'
end