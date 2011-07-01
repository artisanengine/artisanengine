require 'acceptance/acceptance_helper'

feature 'Use Textile in Pages', %q{
  In order to include more than lame plain text in my pages
  As an artisan
  I want to use Textile in my pages.
} do
  
  background do
    # Given I am logged in as an artisan,
    sign_in_as_artisan

    # And I am on the new page page,
    visit new_page_page
  end
  
  scenario "An artisan can use Textile in her pages" do
    # When I fill in some textile content,
    fill_in 'Title',   with: 'My Textiled Page'
    fill_in 'Content', with: 'A *bold* man.'
    
    # And I click Create Page,
    click_button 'Create Page'
    
    # And I visit the page,
    visit_page 'My Textiled Page'
    
    # Then I should see my Textiled content.
    page.should have_selector 'strong', text: 'bold'
  end
  
  scenario "An artisan can preview the displayed Textile of a page she is editing", js: true do
    # When I fill in the content text area with some content,
    fill_in 'Content', with: 'A *bold* man.'
    
    # And I click the Preview link,
    click_link 'Preview'
    
    # Then I should see my formatted content.
    page.should have_selector 'strong', text: 'bold'
  end
end