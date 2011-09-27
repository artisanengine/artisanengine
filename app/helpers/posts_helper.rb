module PostsHelper
  def path_for_post( post )
    blog_post_path( post.published_on.strftime( "%Y" ), post.published_on.strftime( "%m" ), post )
  end
end