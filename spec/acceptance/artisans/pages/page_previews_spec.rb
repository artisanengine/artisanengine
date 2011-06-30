require 'acceptance/acceptance_helper'

feature 'Page Previews', %q{
  In order to review my work before I post it
  As an artisan
  I want to preview my pages.
} do
  
  background do
    # Given I am logged in as an artisan,
    sign_in_as_artisan

    # And I am on the new page page,
    visit new_page_page
  end
  
  scenario "An artisan can preview a page she is editing", js: true do
    # When I fill in the content text area with some content,
    fill_in 'Content', with: 'A *bold* man.'
    
    # And I click the Preview link,
    click_link 'Preview'
    
    # Then I should see my formatted content.
    page.should have_selector 'strong', text: 'bold'
  end
end