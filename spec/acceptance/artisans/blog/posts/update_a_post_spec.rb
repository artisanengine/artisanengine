require 'acceptance/acceptance_helper'

feature 'Update a Post', %q{
  In order to sanitize my thoughts, dreams, and idiosyncracies in the morning
  As an artisan
  I want to update a blog post.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And there is a blog,
    blog = Blog.find_by_name( 'Test Frame Blog' )
    
    # And there is a post,
    Post.generate title: 'Old Title', blog: blog
    
    # And I am on the edit post page,
    visit edit_post_page_for 'Old Title'
  end
  
  scenario "An artisan can edit a post with valid attributes" do
    # When I fill in new valid information for my post,
    fill_in 'Title', with: 'New Title'
    
    # And I click Update Post,
    click_button 'Update Post'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my new post.
    page.should have_content 'New Title'
  end
  
  scenario "An artisan cannot edit a post with invalid attributes" do
    # When I fill in invalid information for my post,
    fill_in 'Title',   with: 'New Title'
    fill_in 'Content', with: ''
    
    # And I click Update Post,
    click_button 'Update Post'
    
    # Then I should see an alert,
    page_should_have_alert
    
    # And I should not see my new post.
    page.should have_no_content 'New Title'
  end
end