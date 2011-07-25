# ------------------------------------------------------------------
# Paths

def new_page_page
  '/manage/pages/new'
end

def visit_page( title )
  page = Page.find_by_title( title )
  visit "/pages/#{ page.id }"
end

def edit_page_page_for( title )
  page = Page.find_by_title( title )
  "/manage/pages/#{ page.id }/edit"
end

def manage_pages_page
  "/manage/pages"
end