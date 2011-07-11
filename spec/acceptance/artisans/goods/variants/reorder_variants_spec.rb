require 'acceptance/acceptance_helper'

feature 'Re-order Variants', %q{
  In order to control the order my good's variants display in
  As an artisan
  I want to re-order my good's variants.
} do

  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good with three variants,
    Factory( :good_with_three_options_and_variants, name: 'Freeze Ray' )
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end 
  
  scenario "An artisan can re-order a good's variants", js: true do
    # When I drag the handle for variant 1 to the handle for variant 3,
    within '#variants' do
      draggable     = all( '.variant' )[0].find( '.handle' )
      @draggable_id = all( '.variant' )[0][:id]
      
      droppable     = all( '.variant' )[2].find( '.handle' )
      @droppable_id = all( '.variant' )[2][:id]
      
      draggable.drag_to( droppable )
    end
    
    # And I reload the page,
    visit edit_good_page_for 'Freeze Ray'
    
    # Then my variants should be in their new order (2, 3, 1).
    within '#variants' do
      all( '.variant' )[1][:id].should == @droppable_id
      all( '.variant' )[2][:id].should == @draggable_id
    end
  end
end