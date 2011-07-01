require 'acceptance/acceptance_helper'

feature 'Automatic Blog Setup', %q{
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
    fill_in 'Title',   with: 'My Left Eyebrow'
    fill_in 'Content', with: 'Stuff and things, things and stuff.'
    
    # And I click Create Post,
    click_button 'Create Post'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # Then I should see my post's title.
    page.should have_content 'My Left Eyebrow'
  end
  
  scenario "An artisan cannot create a post with invalid attributes" do
    # When I fill in invalid attributes for my post,
    fill_in 'Title',   with: ''
    fill_in 'Content', with: 'Stuff and things, things and stuff.'
    
    # And I click Create Post,
    click_button 'Create Post'
    
    # Then I should see an alert,
    page_should_have_alert
    
    # And I should not see my post's title.
    page.should have_no_content 'My Left Eyebrow'
  end
end