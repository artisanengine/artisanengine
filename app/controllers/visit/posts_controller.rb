module Visit
  class PostsController < Visit::VisitController
    def show
      @blog = current_frame.blog
      @post = @blog.posts.find( params[ :id ] )
    end
  end
end