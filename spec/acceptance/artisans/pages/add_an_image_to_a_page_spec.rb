require 'acceptance/acceptance_helper'

feature 'Attach an Image to a Page', %q{
  In order to add panache to my text-drowned diatribes
  As an artisan
  I want to add an image to a page.
} do
  
  background do
    # Given I am logged in as an artisan,
    sign_in_as_artisan
    
    # And I have uploaded an image,
    Image.generate
    
    # And I am creating a new page,
    visit new_page_page
  end
  
  scenario "An artisan can add an existing image to a page", js: true do
    # When I click the Insert Image link,
    click_link 'Insert Image'
    
    # And I click an Insert link in the pop-up window,
    find( 'a.insert_link' ).click
    
    # Then my content field should contain a link to my image.
    page.find_field( 'page_content' ).value.should include 'images'
  end
end