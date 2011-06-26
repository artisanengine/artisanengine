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

def fill_in_information_for_page( options = {} )
  # Options
  title   = options[ :title ]   || 'About Me'
  content = options[ :content ] || 'Some things about me.'
  
  # Action
  fill_in 'Title',   with: title
  fill_in 'Content', with: content
end

def create_page( options = {} )
  visit new_page_page
  fill_in_information_for_page( options )
  click_button 'Create Page'
end