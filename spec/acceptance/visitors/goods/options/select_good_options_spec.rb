require 'acceptance/acceptance_helper'
=begin
feature 'Select a Variant Using Option Drop-Downs', %q{
  In order to select a variation of a good
  As a visitor
  I want to use option drop-downs to choose the variant.
} do
  
  background do
    # Given a good exists,
    good = Good.generate
    
    # And the good has three options,
    3.times { good.options << Option.spawn }
    
    # And the good has three variants,
    # And I am on the show good page for the good,
  end
  
  scenario "A visitor can select a variant using option drop-downs" do
    # There should be three drop-downs.
    page.should have_selector 'select', count: 3
    
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
end
=end