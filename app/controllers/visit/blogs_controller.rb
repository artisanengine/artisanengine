module Visit
  class BlogsController < Visit::VisitController
    def show
      @blog        = current_frame.blog
      @tags        = current_frame.tags
      @recent_post = @blog.posts.order( "created_at DESC" ).first
    end
  end
end