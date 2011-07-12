require 'acceptance/acceptance_helper'

feature 'Create a Post', %q{
  In order to broadcast my thoughts, dreams, and idiosyncracies to the world
  As an artisan
  I want to create a blog post.
} do
  
  background do
    # And I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I am on the new post page,
    visit new_post_page
  end
  
  scenario "An artisan can create a post with valid attributes" do
    # When I fill in valid attributes for my post,
    fill_in 'Title', with: 'My Left Eyebrow'
    
    # And I click Create Post,
    click_button 'Create Post'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # Then I should see my post and my post's title.
    page.should have_selector '.post', text: 'My Left Eyebrow'
  end
  
  scenario "An artisan cannot create a post with invalid attributes" do
    # When I fill in invalid attributes for my post,
    fill_in 'Title', with: ''
    
    # And I click Create Post,
    click_button 'Create Post'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And there should be no posts.
    Post.count.should be 0
  end
end