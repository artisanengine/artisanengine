module PostsHelper
  def path_for_post( post )
    blog_post_path( post.created_at.strftime( "%Y" ), post.created_at.strftime( "%m" ), post.created_at.strftime( "%d" ), post )
  end
end