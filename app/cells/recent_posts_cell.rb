class RecentPostsCell < Cell::Rails
  include FramesHelper
  include ArtisanEngine::Theming

  def display( state )
    frame  = state[ :frame ]
    
    @posts = frame.blog.posts.descending_by_date.limit( 2 )
    render
  end

end
