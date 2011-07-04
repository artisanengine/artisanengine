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
  visit "/blog/posts/#{ post.id }"
end
  