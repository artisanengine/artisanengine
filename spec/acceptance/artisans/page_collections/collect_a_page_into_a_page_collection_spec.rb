require 'acceptance/acceptance_helper'

feature 'Collect a Page into a Page Collection', %q{
  In order to organize my pages
  As an artisan
  I want to collect pages into a page collection.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a page and a page collection,
    Page.generate           title: 'Freeze Ray'
    PageCollection.generate name: 'Tools for Evil'
    
    # And I am on the edit page collection page,
    visit '/manage/page_collections/1/edit'
  end

  scenario "An artisan can add and remove a page from a page collection" do
    # When I click the Add to Case button next to my page,
    within '#uncollected_pages .page' do
      click_button 'Add to Collection'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And the page should be in the case,
    within '#collected_pages' do
      page.should have_content 'Freeze Ray'
    end
    
    # And I should not see the page in the list of uncollected pages.
    within '#uncollected_pages' do
      page.should have_no_content 'Freeze Ray'
    end
    
    # When I click the Remove from Case button next to my page,
    within '#collected_pages .page_collect' do
      click_button 'Remove from Collection'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see the page in the list of uncollected pages,
    within '#uncollected_pages' do
      page.should have_content 'Freeze Ray'
    end
    
    # And I should not see the page in the case.
    within '#collected_pages' do
      page.should have_no_content 'Freeze Ray'
    end
  end
end