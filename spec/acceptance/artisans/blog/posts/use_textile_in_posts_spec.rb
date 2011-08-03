require 'acceptance/acceptance_helper'

feature 'Use Textile in Posts', %q{
  In order to include more than lame plain text in my posts
  As an artisan
  I want to use Textile in my posts.
} do
  
  background do
    # Given I am logged in as an artisan,
    sign_in_as_artisan

    # And I am on the new post page,
    visit new_post_page
  end
  
  scenario "An artisan can use Textile in her posts" do
    # When I fill in some textile content,
    fill_in 'Title',   with: 'My Textiled Post'
    fill_in 'Content', with: 'A *bold* man.'
    fill_in_valid_date
    
    # And I click Create Post,
    click_button 'Create Post'
    
    # And I visit the post,
    visit_post 'My Textiled Post'
    
    # Then I should see my Textiled content.
    page.should have_selector 'strong', text: 'bold'
  end
  
  scenario "An artisan can preview the Textiled version of a post she is editing", js: true do
    # When I fill in the content text area with some Textile content,
    fill_in 'Content', with: 'A *bold* man.'
    
    # And I click the Preview link,
    click_link 'Preview'
    
    # Then I should see my Textiled content.
    page.should have_selector 'strong', text: 'bold'
  end
end