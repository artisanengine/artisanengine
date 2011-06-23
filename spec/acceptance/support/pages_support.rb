# ------------------------------------------------------------------
# Paths

def new_page_page
  '/manage/pages/new'
end

# ------------------------------------------------------------------
# Actions

def create_page( options = {} )
  # Options
  title   = options[ :title ]   || 'About Me'
  content = options[ :content ] || 'Some things about me.'
  
  # Action
  visit new_page_page
  
  fill_in 'Title',   with: title
  fill_in 'Content', with: content

  click_button 'Create Page'
end