# ------------------------------------------------------------------
# Paths

def new_post_page
  '/manage/blog/posts/new'
end

def edit_post_page_for( title )
  post = Post.find_by_title( title )
  "/manage/blog/posts/#{ post.id }/edit"
end

def visit_post( title )
  post = Post.find_by_title( title )
  visit "/blog/#{ post.created_at.strftime( "%Y" ) }/#{ post.created_at.strftime( "%m" ) }/#{ post.id }"
end

def fill_in_valid_date
  select '2006',  from: 'Year'
  select 'March', from: 'Month'
  select '18',    from: 'Day'
  select '20',    from: 'Hour'
  select '05',    from: 'Minute'
end
  