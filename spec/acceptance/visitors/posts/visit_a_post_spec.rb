require 'acceptance/acceptance_helper'

feature 'Visit a Post', %q{
  In order to view an artisan's ramblings
  As a visitor
  I want to visit a post.
} do
  
  background do
    # Given a test artisan has created a post,
    frame1  = use_frame( 'ae.test' )
    ae_blog = frame1.blog
    Post.generate title: 'Example Post', blog: ae_blog 

    # And a Haus Leather artisan has created a post,
    frame2    = use_frame( 'hausleather.test' )
    haus_blog = frame2.blog
    Post.generate title: 'Haus Leather Post', blog: haus_blog
    
    # And I am a visitor browsing the test frame,
    browse_frame 'ae.test'
  end
  
  scenario "A visitor can visit a post in the current frame" do        
    # When I visit the Example page,
    visit_post 'Example Post'

    # Then I should see the Example post.
    page.should have_content 'Example Post'
  end
  
  scenario "A visitor cannot visit a post in a different frame" do
    # When I visit the Haus Leather post,
    visit_post 'Haus Leather Post'
    
    # Then I should not see the post,
    page.should have_no_content 'Haus Leather Post'
  end
end