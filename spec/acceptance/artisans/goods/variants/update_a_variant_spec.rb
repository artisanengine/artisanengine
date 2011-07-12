require 'acceptance/acceptance_helper'

feature 'Update a Variant', %q{
  In order to change the different variations of my good
  As an artisan
  I want to update a variant.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good with a variant,
    Good.generate name: 'Freeze Ray'
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end
  
  scenario "An artisan can update a variant with valid attributes" do
    # When I click the Edit link for the variant,
    within '.variant' do
      click_link 'Edit'
    end
  
    # And I fill in valid attributes for the variant,
    fill_in 'Type', with: 'Extra Saucy'
      
    # And I click Update Variant,
    click_button 'Update Variant'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my updated variant,
    page.should have_selector '.variant', text: 'Extra Saucy'
  end

  scenario "An artisan cannot update a variant with invalid attributes" do
    # When I click the Edit link for the variant,
    within '.variant' do
      click_link 'Edit'
    end
    
    # And I fill in invalid attributes for the variant,
    fill_in 'Type', with: ''
    
    # And I click Update Variant,
    click_button 'Update Variant'
    
    # Then I should see an error,
    page_should_have_error
    
    # And my variant's attributes should not change.
    Variant.last.option_value_1.should == 'Default'
  end
end