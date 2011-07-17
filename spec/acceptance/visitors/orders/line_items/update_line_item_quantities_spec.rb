require 'acceptance/acceptance_helper'

feature "Update Line Item Quantities", %q{
  In order to buy multiple copies of an item
  As a visitor
  I want to add the quantities of the line items in my order.
} do
  
  background do
    # Given there are three goods,
    monkey1 = Good.generate name: 'See No Evil Monkey'
    monkey1.variants.first.update_attributes price: 100
    
    monkey2 = Good.generate name: 'Hear No Evil Monkey'
    monkey2.variants.first.update_attributes price: 100
    
    monkey3 = Good.generate name: 'Speak No Evil Monkey'
    monkey3.variants.first.update_attributes price: 100
    
    # And I have added each of them to my order,
    for monkey in [ monkey1, monkey2, monkey3 ]
      visit good_page_for monkey.name
      click_button 'Add to Order'
    end
    
    # And I am on the order page,
    visit order_page
  end
  
  scenario "A visitor can update the quantities of line items in his order" do
    # When I fill in the quantities 0, 1, and 3,
    within '.line_item', text: 'See No Evil' do
      fill_in "line_item_#{ LineItem.all[0].id }", with: '0'
    end
    
    within '.line_item', text: 'Hear No Evil' do
      fill_in "line_item_#{ LineItem.all[1].id }", with: '1'
    end
    
    within '.line_item', text: 'Speak No Evil' do
      fill_in "line_item_#{ LineItem.all[2].id }", with: '3'
    end
    
    # And I press Update,
    click_button 'Update'
    
    # Then I should see an updated order total.
    page.should have_selector '.total', text: "$400.00"
  end
end