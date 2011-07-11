module Visit
  class BlogsController < Visit::VisitController
    layout :blog_or_visit
    
    expose( :blog )        { current_frame.blog }
    expose( :tags )        { current_frame.tags }
    expose( :recent_post ) { blog.posts.order( "created_at DESC" ).first }
    
    # ------------------------------------------------------------------
    private
    
    def blog_or_visit
      template_exists?( "layouts/blog" ) ? 'blog' : 'visit'
    end
  end
end