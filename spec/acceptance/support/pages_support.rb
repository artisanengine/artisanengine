# ------------------------------------------------------------------
# Paths

def new_page_page
  '/manage/pages/new'
end

def visit_page( title )
  page = Page.find_by_title( title )
  visit "/pages/#{ page.id }"
end