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
  
  scenario "A visit can see all posts" do
    # Given there is a post from 2010 and a post from 2011,
    Post.generate title: '2010 Post', created_at: Date.new( 2010 ), blog: @ae_blog
    Post.generate title: '2011 Post', created_at: Date.new( 2011 ), blog: @ae_blog
    
    # And I am on the blog posts page,
    visit '/blog/posts'
    
    # Then I should see the posts
    page.should have_content '2010 Post'
    page.should have_content '2011 Post'
  end
  
  scenario "A visitor can filter posts by year" do
    # Given there is a post from 2010 and a post from 2011,
    Post.generate title: '2010 Post', created_at: Date.new( 2010 ), blog: @ae_blog
    Post.generate title: '2011 Post', created_at: Date.new( 2011 ), blog: @ae_blog
    
    # And I am on the archive page for 2011,
    visit '/blog/2011'
    
    # Then I should see the post from 2011
    page.should have_content '2011 Post'
    
    # And I should not see the post from 2010
    page.should have_no_content '2010 Post'
  end
  
  scenario "A visitor can filter posts by month" do
    # Given there is a post from June 2010 and a post from July 2010,
    Post.generate title: 'June Post', created_at: Date.new( 2010, 6 ), blog: @ae_blog
    Post.generate title: 'July Post', created_at: Date.new( 2010, 7 ), blog: @ae_blog
    
    # And I am on the archive page for July 2010,
    visit '/blog/2010/07'
    
    # Then I should see the post from July
    page.should have_content 'July Post'
    
    # And I should not see the post from June
    page.should have_no_content 'June Post'
  end
  
  scenario "A visitor can filter posts by day" do
    # Given there is a post from January 1st, 2010 and a post from January 2nd, 2010.
    Post.generate title: '1st Post', created_at: Date.new( 2010, 1, 1 ), blog: @ae_blog
    Post.generate title: '2st Post', created_at: Date.new( 2010, 1, 2 ), blog: @ae_blog
    
    # And I am on the archive page for January 1st, 2010,
    visit '/blog/2010/01/01'
    
    # Then I should see the post from the 1st,
    page.should have_content '1st Post'
    
    # And I should not see the post from the 2nd.
    page.should have_no_content '2nd Post'
  end
  
  scenario "A visitor can filter posts by tag" do
    # Given there is a post tagged Awesome and a post tagged Mediocre,
    Post.generate title: 'Awesome Post',  tag_names: 'Awesome',  blog: @ae_blog
    Post.generate title: 'Mediocre Post', tag_names: 'Mediocre', blog: @ae_blog
    
    # And I am on the blog tag page,
    visit '/blog/posts?tagged_with=Awesome'
    
    # Then I should see the Awesome post,
    page.should have_content 'Awesome Post'
    
    # And I should not see the Mediocre post.
    page.should have_no_content 'Mediocre Post'
  end
end