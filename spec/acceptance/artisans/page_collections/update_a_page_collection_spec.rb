require 'acceptance/acceptance_helper'

feature 'Update a page collection', %q{
  In order to re-organize my goods
  As an artisan
  I want to update a page collection.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a page collection,
    PageCollection.generate name: 'Stuff'
    
    # And I am on the Edit page collection page,
    visit '/manage/page_collections/1/edit'
  end
  
  scenario "An artisan can update a page collection with valid attributes" do
    # When I fill in valid new attributes for the page collection,
    fill_in 'Name', with: 'New Stuff'
    
    # And I click Update page collection,
    click_button 'Update Page Collection'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my updated page collection.
    page.should have_selector '.page_collection', text: 'New Stuff'
  end
  
  scenario "An artisan cannot update a page collection with invalid attributes" do
    # When I fill in invalid new attributes for the page collection,
    fill_in 'Name', with: ''
    
    # And I click Update page collection,
    click_button 'Update Page Collection'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And my page collection's attributes should not change.
    PageCollection.last.name.should == 'Stuff'
  end
    
end