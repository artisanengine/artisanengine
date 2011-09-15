# TODO: Create sample app and raise an issue with decent_exposure. 
# Exposing "tag" here instead of "requested_tag" 
# breaks any method with the word "tag" in it.

module Visit
  class PostsController < Visit::VisitController
    include PostsHelper
    
    layout :blog_or_visit
    
    before_filter :ensure_best_url, only: :show
    
    respond_to :html, :xml

    expose( :blog )          { current_frame.blog }
    expose( :posts )         { load_posts! }
    expose( :post )
    expose( :tags )          { current_frame.tags }
    expose( :requested_tag ) { tags.find( params[ :tag_id ] ) }
    
    # ------------------------------------------------------------------
    private
    
    def blog_or_visit
      template_exists?( "layouts/blog" ) ? 'blog' : 'visit'
    end
    
    def load_posts!
      if params[ :year ] and params[ :month ]
        posts = blog.posts.published.by_month( params[ :year ], params[ :month ] )
      elsif params[ :year ]
        posts = blog.posts.published.by_year( params[ :year ] )
      else
        posts = blog.posts
      end
      
      if params[ :tagged_with ]
        posts = posts.published.tagged_with( params[ :tagged_with ] )
      end
      
      posts.descending_by_date
    end
    
    # Ensure page is accessed from the best Friendly ID.
    def ensure_best_url
      redirect_to path_for_post( post ), status: 301 unless post.friendly_id_status.best?
    end
  end
end