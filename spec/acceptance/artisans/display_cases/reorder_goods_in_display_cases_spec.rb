require 'acceptance/acceptance_helper'

feature 'Re-order Goods in Display Cases', %q{
  In order to control the order my goods display in
  As an artisan
  I want to re-order the goods in a display case.
} do

  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created three goods and a display case,
    display_case = DisplayCase.generate name: 'Ridiculous Wobbles'
    3.times { display_case.goods << Good.spawn }
    
    # And I am on the edit display case page for the case,
    visit edit_display_case_page_for 'Ridiculous Wobbles'
  end 
  
  scenario "An artisan can re-order the goods in a display case", js: true do
    # When I drag the handle for collect 1 to the handle for collect 3,
    within '#collected_goods' do
      draggable     = all( '.collect' )[0].find( '.handle' )
      @draggable_id = all( '.collect' )[0][:id]
      
      droppable     = all( '.collect' )[2].find( '.handle' )
      @droppable_id = all( '.collect' )[2][:id]
      
      draggable.drag_to( droppable )
    end
    
    # And I reload the page,
    visit edit_display_case_page_for 'Ridiculous Wobbles'
    
    # Then my collects should be in their new order (2, 3, 1).
    within '#collected_goods' do
      all( '.collect' )[1][:id].should == @droppable_id
      all( '.collect' )[2][:id].should == @draggable_id
    end
  end
end