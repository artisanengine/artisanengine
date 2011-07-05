require 'acceptance/acceptance_helper'

feature 'Visit the Blog', %q{
  In order to view an artisan's collected ramblings
  As a visitor
  I want to visit the blog.
} do

  background do
    # Given a test artisan has created a blog,
    frame1  = use_frame( 'ae.test' )
    ae_blog = frame1.blog
    Post.generate title: 'Example Post', blog: ae_blog 

    # And I am a visitor browsing the test frame,
    browse_frame 'ae.test'
  end
  
  scenario "A visitor can visit the blog" do
    # When I visit the blog page,
    visit blog_page
    
    # Then I should see the blog.
    page.should have_content 'Blog'
  end
end