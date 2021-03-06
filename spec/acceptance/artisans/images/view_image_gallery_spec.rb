require 'acceptance/acceptance_helper'

feature 'Image Gallery', %q{
  In order to see all my uploaded images
  As an artisan
  I want to see an image gallery.
} do
  
  background do
    # Given I have uploaded five images,
    5.times { Image.generate }
    
    # And I am logged in as an artisan,
    sign_in_as_artisan
  end
  
  scenario "An artisan can see all her uploaded images" do
    # When I visit the images page,
    visit images_page
    
    # Then I should see five images.
    page.should have_selector 'img', count: 5
  end
end