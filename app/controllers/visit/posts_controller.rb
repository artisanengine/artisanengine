module Visit
  class PostsController < Visit::VisitController
    layout :blog_or_visit
    
    def index
      @blog  = current_frame.blog
      @posts = @blog.posts.by_year( params[ :year ] ).order( "created_at DESC" ) if params[ :year ]
      @tags  = current_frame.tags
      
      if params[ :tag_id ]
        @tag = current_frame.tags.find( params[ :tag_id ] )
        render_404 unless @tag
        @posts = @blog.posts.order( "created_at DESC" ).tagged_with( @tag )
      end
    end
    
    def show
      @blog = current_frame.blog
      @post = @blog.posts.order( "created_at DESC" ).find( params[ :id ] )
      @tags = current_frame.tags
    end
    
    private
    
    def blog_or_visit
      template_exists?( "layouts/blog" ) ? 'blog' : 'visit'
    end
  end
end