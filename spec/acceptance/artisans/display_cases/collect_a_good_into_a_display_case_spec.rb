require 'acceptance/acceptance_helper'

feature 'Collect a Good into a Display Case', %q{
  In order to organize my goods
  As an artisan
  I want to collect a good into a display case.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good and display case,
    Good.generate        name: 'Freeze Ray'
    DisplayCase.generate name: 'Tools for Evil'
    
    # And I am on the edit display case page,
    visit edit_display_case_page_for 'Tools for Evil'
  end

  scenario "An artisan can add and remove a good from a display case" do
    # When I click the Add to Case button next to my good,
    within '#uncollected_goods .good' do
      click_button 'Add to Case'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And the good should be in the case,
    within '#collected_goods' do
      page.should have_content 'Freeze Ray'
    end
    
    # And I should not see the good in the list of uncollected goods.
    within '#uncollected_goods' do
      page.should have_no_content 'Freeze Ray'
    end
    
    # When I click the Remove from Case button next to my good,
    within '#collected_goods .collect' do
      click_button 'Remove from Case'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see the good in the list of uncollected goods,
    within '#uncollected_goods' do
      page.should have_content 'Freeze Ray'
    end
    
    # And I should not see the good in the case.
    within '#collected_goods' do
      page.should have_no_content 'Freeze Ray'
    end
  end
end