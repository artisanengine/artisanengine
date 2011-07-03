require 'acceptance/acceptance_helper'

feature 'Delete a Variant', %q{
  In order to reduce the different variations of my good
  As an artisan
  I want to delete a variant.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good with three variants,
    Factory :good_with_3_variants, name: 'Freeze Ray'
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end

  scenario "An artisan can delete a variant" do
    # When I click the Delete button on the third variant,
    within '.variant:last-child' do
      click_link 'Delete'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And there should only be two variants.
    page.should have_selector '.variant', count: 2
  end
end