require 'acceptance/acceptance_helper'

feature 'Re-order Good Images', %q{
  In order to control the order my good's images display in
  As an artisan
  I want to re-order my good's images.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good with three images,
    g       = Good.generate name: 'Freeze Ray'
    3.times { g.images << Image.spawn }
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end 
  
  scenario "An artisan can re-order a good's images", js: true do
    # When I drag the handle for image 3 to the handle for image 1,
    within '#good_images' do
      draggable = all( '.image' )[0].find( '.handle' )
      droppable = all( '.image' )[2].find( '.handle' )
      draggable.drag_to( droppable )
    end
    
    # Then my images should be in their new order.
    within '#good_images' do
      find( '.image' )[0].should have_content 'ladooga'
    end
  end
end