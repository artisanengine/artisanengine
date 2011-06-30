require 'spec_helper'

describe RecentPostsCell do
  context "display: " do
    let( :frame ) { Frame.generate }
    let( :blog )  { frame.blog }       # Auto-generated on frame creation.
    
    let( :cell )  { render_cell( :recent_posts, :display, frame: frame ) }
    
    before do
      # Given there is a blog with 3 posts ...
      blog.posts << Post.spawn( title: 'Antipode' )
      blog.posts << Post.spawn( title: 'Laffabil' )
      blog.posts << Post.spawn( title: 'Gulag' )
    end
    
    it "shows the two most recent posts from the given frame's blog" do
      cell.should have_content     'Antipode'
      cell.should have_content     'Laffabil'
      cell.should_not have_content 'Gulag'
    end
  end
end