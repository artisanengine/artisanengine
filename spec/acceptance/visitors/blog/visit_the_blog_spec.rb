require 'acceptance/acceptance_helper'

feature 'Visit the Blog', %q{
  In order to view an artisan's collected ramblings
  As a visitor
  I want to visit the blog.
} do

  background do
    # Given a test artisan has created a blog and two posts,
    frame1   = use_frame( 'ae.test' )
    @ae_blog = frame1.blog
    
    # And I am a visitor browsing the test frame,
    browse_frame 'ae.test'
  end
  
  scenario "A visitor can visit the blog" do
    # When I visit the blog page,
    visit blog_page
    
    # Then I should see the blog.
    page.should have_content 'Blog'
  end
  
  scenario "A visitor sees the most recent post when visiting the blog" do
    # Given there are two posts,
    Post.generate title: 'Example Post', blog: @ae_blog, created_at: 2.days.ago
    Post.generate title: 'Recent Post',  blog: @ae_blog, created_at: 1.day.ago
    
    # And I am on the blog page,
    visit blog_page
    
    # Then I should only see the most recent post.
    page.should have_content    'Recent Post'
    page.should have_no_content 'Example Post'
  end
end