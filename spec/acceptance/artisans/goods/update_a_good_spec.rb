require 'acceptance/acceptance_helper'

feature 'Update a Good', %q{
  In order to change information about my goods
  As an artisan
  I want to update a good.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good,
    Good.generate name: 'Freeze Ray'
    
    # And I am on the Edit Good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end
  
  scenario "An artisan can update a good with valid attributes" do
    # When I update the good with valid attributes,
    within '#basics' do
      fill_in 'Name', with: "It's Not a Death Ray"
      click_button 'Update Good'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my good's updated title.
    page.should have_content "It's Not a Death Ray"
  end
  
  scenario "An artisan cannot update a good with invalid attributes" do
    # When I update the good with invalid attributes,
    within '#basics' do
      fill_in 'Name', with: ""
      click_button 'Update Good'
    end
    
    # Then I should see an alert,
    page_should_have_alert
    
    # And my good's attributes should not change.
    Good.last.name.should == "Freeze Ray"
  end
end