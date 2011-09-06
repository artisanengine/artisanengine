require 'acceptance/acceptance_helper'

feature 'Create a Page Collection', %q{
  In order to organize my goods
  As an artisan
  I want to create a Page Collection.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I am on the new Page Collection page,
    visit '/manage/page_collections/new'
  end
  
  scenario "An artisan can create a Page Collection with valid attributes" do
    # When I fill in valid attributes for the collection,
    fill_in 'Name', with: 'Some Pages'
    
    # And I click Create Page Collection,
    click_button 'Create Page Collection'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my new Page Collection.
    page.should have_selector '.page_collection', name: 'Some Pages'
  end
  
  scenario "An artisan cannot create a Page Collection with invalid attributes" do
    # When I fill in invalid attributes for the Page Collection,
    fill_in 'Name', with: ''
    
    # And I click Create Page Collection,
    click_button 'Create Page Collection'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And there should be no Page Collections.
    PageCollection.count.should be 0
  end
end