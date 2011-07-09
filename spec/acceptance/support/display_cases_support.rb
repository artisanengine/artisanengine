# ------------------------------------------------------------------
# Paths

def new_display_case_page
  '/manage/display_cases/new'
end

def edit_display_case_page_for( name )
  display_case = DisplayCase.find_by_name( name )
  "/manage/display_cases/#{ display_case.id }/edit"
end

def manage_display_cases_page
  '/manage/display_cases'
end

def display_case_page_for( name )
  display_case = DisplayCase.find_by_name( name )
  "/collections/#{ display_case.id }/"
end