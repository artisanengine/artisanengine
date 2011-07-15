require 'acceptance/acceptance_helper'

feature "Add a Line Item to an Order", %q{
  In order to choose the items I want to buy
  As a visitor
  I want to add a line item to my order.
} do
  
  background do
    # Given there is a good named Rocket to the Stars
    good = Good.generate name: 'Rocket to the Stars'
    
    # And its only variant has a price of 5000,
    good.variants.first.update_attributes price: 5000
    
    # And I am on its show good page
    visit '/goods/rocket-to-the-stars'
    
    # And I click the Add to Order button,
    click_button 'Add to Order'
  end
  
  scenario "A visitor can add a line item to her order" do     
    # Then I should see a line item with:
    within '.line_item' do
      
      # The good's name,
      page.should have_content 'Rocket to the Stars'
      
      # The variant's price,
      page.should have_content '$5,000'
    
      # A quantity of 1.
      page.first( 'input' ).value.should == '1'
      
    end
  end
end