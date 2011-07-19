# TODO: Create sample app and raise an issue with decent_exposure. 
# Exposing "tag" here instead of "requested_tag" 
# breaks any method with the word "tag" in it.

# TODO: Possibly refactor this using has_scope and change URLs to query
# strings.

module Visit
  class PostsController < Visit::VisitController
    layout :blog_or_visit

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
      if params[ :year ] and params[ :month ] and params[ :day ]
        posts = blog.posts.by_day( params[ :year ], params[ :month ], params[ :day ] )
      elsif params[ :year ] and params[ :month ]
        posts = blog.posts.by_month( params[ :year ], params[ :month ] )
      elsif params[ :year ]
        posts = blog.posts.by_year( params[ :year ] )
      else
        posts = blog.posts
      end
      
      if params[ :tagged_with ]
        posts = posts.tagged_with( params[ :tagged_with ] )
      end
      
      posts.descending_by_date
    end
  end
end