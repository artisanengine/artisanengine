require 'acceptance/acceptance_helper'

feature 'Filter Posts', %q{
  In order to view specific artisan's ramblings
  As a visitor
  I want to filter posts.
} do
  
  background do
    # Given a test artisan has created a blog,
    frame1   = use_frame( 'ae.test' )
    @ae_blog = frame1.blog
    
    # And I am browsing the test frame,
    browse_frame 'ae.test'
  end
  
  scenario "A visitor can filter posts by year" do
    # Given there is a post from 2010 and a post from 2011,
    Post.generate title: '2010 Post', blog: @ae_blog, created_at: Date.new( 2010 )
    Post.generate title: '2011 Post', blog: @ae_blog, created_at: Date.new( 2011 )
    
    # And I am on the blog page,
    visit blog_page
    
    # When I click "2010" in the By Year section,
    click_link '2010'
    
    # Then I should see the post from 2010
    page.should have_content '2010 Post'
    
    # And I should not see the post from 2011
    page.should have_no_content '2011 Post'
  end
end