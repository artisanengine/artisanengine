module Visit
  class BlogsController < Visit::VisitController
    layout :blog_or_visit
    
    def show
      @blog        = current_frame.blog
      @tags        = current_frame.tags
      @recent_post = @blog.posts.order( "created_at DESC" ).first
    end
    
    private
    
    def blog_or_visit
      template_exists?( "layouts/blog" ) ? 'blog' : 'visit'
    end
  end
end