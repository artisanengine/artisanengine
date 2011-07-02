require 'acceptance/acceptance_helper'

feature 'Tag Posts', %q{
  In order to organize my thoughts, dreams, and idiosyncracies
  As an artisan
  I want to add and remove tags from a blog post.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And there is a blog,
    blog = Blog.find_by_name( 'Test Frame Blog' )
    
    # And there is a post in the blog,
    Post.generate title: 'Tagged Post', blog: blog
    
    # And I am on the edit post page,
    visit edit_post_page_for 'Tagged Post'
  end
  
  scenario "An artisan can add and remove tags from a post" do
    # When I fill in some tags,
    fill_in 'Tags', with: 'apple, bat, cow'
    
    # And I Update Post,
    click_button 'Update Post'
    
    # Then I should see my tags with my post.
    within '.post', text: 'Tagged Post' do
      page.should have_content 'apple'
      page.should have_content 'bat'
      page.should have_content 'cow'
    end
    
    # And when I update the post to have only one tag,
    visit edit_post_page_for 'Tagged Post'
    fill_in 'Tags', with: 'apple'
    click_button 'Update Post'
    
    # Then I should see only one tag with my post.
    within '.post', text: 'Tagged Post' do
      page.should have_content    'apple'
      page.should have_no_content 'bat'
      page.should have_no_content 'cow'
    end
  end
end