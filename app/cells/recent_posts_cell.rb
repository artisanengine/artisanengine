class RecentPostsCell < Cell::Rails

  def display( state )
    frame = state[ :frame ]
    @posts = frame.blog.posts.order( "posts.created_at DESC" ).limit( 2 )
    render
  end

end
