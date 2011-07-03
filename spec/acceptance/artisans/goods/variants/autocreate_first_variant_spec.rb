require 'acceptance/acceptance_helper'

feature 'Auto-Create First Variant', %q{
  In order to expedite the process of adding variants to goods
  As an artisan
  I want the first variant of a good to be created for me.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good,
    Good.generate name: 'Freeze Ray'
    
    # And I am on the manage good page for the good,
    visit manage_good_page_for 'Freeze Ray'
  end
  
  scenario "The first variant of a good is auto-created when the good is created" do
    # Then I should see the default first option,
    page.should have_selector '#good .option', text: 'Type'
    
    # And I should see a variant with a default option value for the default option.
    within '#good .variant' do
      page.should have_content 'Default'
    end
  end
end