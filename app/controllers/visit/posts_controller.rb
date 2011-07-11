# TODO: Create sample app and raise an issue with decent_exposure. 
# Exposing "tag" here instead of "requested_tag" 
# breaks any method with the word "tag" in it.

module Visit
  class PostsController < Visit::VisitController
    layout :blog_or_visit
    
    expose( :blog )          { current_frame.blog }
    
    expose( :tags )          { current_frame.tags }
    expose( :requested_tag ) { tags.find( params[ :tag_id ] ) }
    
    expose( :posts ) do
      if params[ :year ]
        blog.posts.by_year( params[ :year ] ).order( "created_at DESC" )
      elsif params[ :tag_id ]
        blog.posts.tagged_with( requested_tag ).order( "created_at DESC" )
      else
        blog.posts
      end
    end
    
    expose( :post )
    
    # ------------------------------------------------------------------
    private
    
    def blog_or_visit
      template_exists?( "layouts/blog" ) ? 'blog' : 'visit'
    end
  end
end