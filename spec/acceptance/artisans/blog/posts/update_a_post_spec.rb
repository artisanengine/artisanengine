require 'acceptance/acceptance_helper'

feature 'Update a Post', %q{
  In order to reconsider my thoughts, dreams, and idiosyncracies in the morning
  As an artisan
  I want to update a blog post.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And there is a blog,
    blog = Blog.find_by_name( 'Test Frame Blog' )
    
    # And there is a post in the blog,
    Post.generate title: 'Old Title', blog: blog
    
    # And I am on the edit post page,
    visit edit_post_page_for 'Old Title'
  end
  
  scenario "An artisan can update a post with valid attributes" do
    # When I fill in new valid information for my post,
    fill_in 'Title', with: 'New Title'
    
    # And I click Update Post,
    click_button 'Update Post'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my new post.
    page.should have_selector '.post', text: 'New Title'
  end
  
  scenario "An artisan cannot update a post with invalid attributes" do
    # When I fill in invalid information for my post,
    fill_in 'Title', with: ''
    
    # And I click Update Post,
    click_button 'Update Post'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And my post's information should not change.
    Post.last.title.should == 'Old Title'
  end
end