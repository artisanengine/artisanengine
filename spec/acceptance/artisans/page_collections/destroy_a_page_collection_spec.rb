require 'acceptance/acceptance_helper'

feature 'Destroy a Page Collection', %q{
  In order to re-organize my page collections
  As an artisan
  I want to destroy a page collection.
} do
  
  background do
    sign_in_as_artisan
    PageCollection.generate name: 'Stuff'
    visit '/manage/page_collections'
  end
  
  scenario "An artisan can destroy a page collection" do
    # When I click the Delete link for the display case,
    within '.page_collection', text: 'Stuff' do
      click_link 'Delete'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should not see the display case.
    page.should have_no_selector '.page_collection', text: 'Stuff'
  end
end