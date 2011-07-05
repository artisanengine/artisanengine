module Visit
  class PostsController < Visit::VisitController
    def index
      @blog  = current_frame.blog
      @posts = @blog.posts.by_year( params[ :year ] )
    end
    
    def show
      @blog = current_frame.blog
      @post = @blog.posts.find( params[ :id ] )
    end
  end
end