require 'acceptance/acceptance_helper'

feature 'Create a Variant', %q{
  In order to sell different variations of my goods
  As an artisan
  I want to create a variant.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good with two options,
    Factory :good_with_size_and_color, name: 'Freeze Ray'
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end
  
  scenario "An artisan can add a variant to a good with valid attributes" do
    # When I fill in the Add Variant section with valid attributes,
    within '#add_variant' do
      fill_in 'Size',  with: 'Medium'
      fill_in 'Color', with: 'Red'
      fill_in 'Price', with: '$50.00'
      click_button 'Add Variant'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my variant as the second variant.
    within '.variant:last-child' do
      page.should have_content 'Medium'
      page.should have_content 'Red'
      page.should have_content '$50.00'
    end
  end
  
  scenario "An artisan cannot add a variant to a good with invalid attributes" do
    # When I fill in the Add Variant section with invalid attributes,
    within '#add_variant' do
      fill_in 'Size', with: 'Medium'
      click_button 'Add Variant'
    end
    
    # Then I should not see my variant.
    page.should_not have_selector '.variant', text: 'Medium'
  end
end