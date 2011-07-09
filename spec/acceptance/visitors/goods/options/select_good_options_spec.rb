require 'acceptance/acceptance_helper'

feature 'Select a Variant Using Option Drop-Downs', %q{
  In order to select a variation of a good
  As a visitor
  I want to use option drop-downs to choose the variant.
} do
  
  background do
    # Given a good exists with three options and three variants,
    good = Factory( :good_with_three_options_and_variants, name: 'Bag of Tricks' )
    
    # And I am on the show good page for the good,
    visit good_page_for 'Bag of Tricks'
  end
  
  scenario "A visit can select a variant using the variant drop-down" do
    # Then I should see a variant drop down.
    page.should have_selector 'select#variant' do
      page.should have_selector 'option', text: 'Small / Blue / Cloth'
      page.should have_selector 'option', text: 'Medium / Blue / Cloth'
      page.should have_selector 'option', text: 'Medium / Red / Cloth'
    end
  end

  scenario "A visitor can select a variant using option drop-downs", js: true do
    # The Size drop-down should have Small, Medium, and Large options.
    within 'select#size' do
      page.should have_selector 'option', text: 'Small'
      page.should have_selector 'option', text: 'Medium'
      page.should have_selector 'option', text: 'Large'
    end
    
    # The Color drop-down should have Red and Blue options.
    within 'select#color' do
      page.should have_selector 'option', text: 'Red'
      page.should have_selector 'option', text: 'Blue'
    end
    
    # The Material drop-down should have Cloth option.
    within 'select#material' do
      page.should have_selector 'option', text: 'Cloth'
    end
  end
  
  scenario "The price updates automatically when a variant is selected"
end