module Visit
  class PostsController < Visit::VisitController
    def index
      @blog  = current_frame.blog
      @posts = @blog.posts.by_year( params[ :year ] ) if params[ :year ]
      
      if params[ :tag_id ]
        @tag = current_frame.tags.find( params[ :tag_id ] )
        render_404 unless @tag
        @posts = @blog.posts.tagged_with( @tag )
      end
    end
    
    def show
      @blog = current_frame.blog
      @post = @blog.posts.find( params[ :id ] )
    end
  end
end