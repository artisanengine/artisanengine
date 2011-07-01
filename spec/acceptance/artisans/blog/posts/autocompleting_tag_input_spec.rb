require 'acceptance/acceptance_helper'

feature 'Autocompleting Tag Input', %q{
  In order to expedite my process of adding tags
  As an artisan
  I want tag suggestions as I type.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And three tags exist,
    Tag.generate name: 'man'
    Tag.generate name: 'bear'
    Tag.generate name: 'pig'
    
    # And I am on the new post page,
    visit new_post_page
  end
  
  scenario "Tags are automatically suggested for me when I type into the Tags input field", js: true, js_driver: :selenium do
    # When I fill in the Tags field with "an"
    fill_in 'token-input-post_tag_names', with: 'an'
    
    # Then I should see "man"
    page.should have_content    'man'
    page.should have_no_content 'bear'
    page.should have_no_content 'pig'
    
    # When I fill in the Tags field with "a"
    fill_in 'token-input-post_tag_names', with: 'a'
    
    # Then I should see "man" and "bear"
    page.should have_content    'man'
    page.should have_content    'bear'
    page.should have_no_content 'pig'
    
    # When I fill in the Tags field with "pig"
    fill_in 'token-input-post_tag_names', with: 'pig'
    
    # Then I should see "pig"
    page.should have_no_content 'man'
    page.should have_no_content 'bear'
    page.should have_content    'pig'
  end
  
  scenario "An artisan can create a new tag in the auto-suggest field", js: true, js_driver: :selenium do
    # When I fill in the Tags field with "nonexistent",
    fill_in 'token-input-post_tag_names', with: 'nonexistent'
    
    # Then I should see an option to create a new tag.
    page.should have_content 'nonexistent (new)'
    
    # When I select the new tag,
    find( 'li', text: 'nonexistent (new)' ).click
    
    # And I fill in valid information for the post,
    fill_in 'Title',   with: 'New Post'
    fill_in 'Content', with: 'New post.'
    
    # And I click Create Post,
    click_button 'Create Post'
    
    # Then I should see the new post with the new tag.
    within '.post', text: 'New Post' do
      page.should have_content 'nonexistent'
    end
  end
end