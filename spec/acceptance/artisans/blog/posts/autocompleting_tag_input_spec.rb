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
  
  scenario "Tags are automatically suggested for me when I type into the Tags input field", js: true do
    # When I fill in the Tags field with "an"
    fill_in 'Tags', with: 'an'
    
    # Then I should see "man"
    page.should have_content 'man'
    
    # When I fill in the Tags field with "a"
    # Then I should see "man" and "bear"
    # When I fill in the Tags field with "pig"
    # Then I should see "pig"
  end
end