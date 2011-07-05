module Visit
  class BlogsController < Visit::VisitController
    def show
      @blog        = current_frame.blog
      @recent_post = @blog.posts.order( "created_at DESC" ).first
    end
  end
end