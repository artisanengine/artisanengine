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
    Post.generate title: '2010 Post', created_at: Date.new( 2010 ), blog: @ae_blog
    Post.generate title: '2011 Post', created_at: Date.new( 2011 ), blog: @ae_blog
    
    # And I am on the blog page,
    visit blog_page
    
    # When I click "2010" in the By Year section,
    click_link '2010'
    
    # Then I should see the post from 2010
    page.should have_content '2010 Post'
    
    # And I should not see the post from 2011
    page.should have_no_content '2011 Post'
  end
  
  scenario "A visit can filter posts by tag" do
    # Given there is a post tagged Awesome and a post tagged Mediocre,
    Post.generate title: 'Awesome Post',  tag_names: 'Awesome',  blog: @ae_blog
    Post.generate title: 'Mediocre Post', tag_names: 'Mediocre', blog: @ae_blog
    
    # And I am on the blog page,
    visit blog_page

    # When I click 'Awesome' in the By Topic section,
    click_link 'Awesome'
    
    # Then I should see the Awesome post,
    page.should have_content 'Awesome Post'
    
    # And I should not see the Mediocre post.
    page.should have_no_content 'Mediocre Post'
  end
end