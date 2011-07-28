require 'acceptance/acceptance_helper'

feature 'Add a Cropping to an Image', %q{
  In order to display my images differently around the site
  As an artisan
  I want to add a cropping to an image.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created an image,
    Image.generate
    
    # And I am on the edit image page for the image,
    visit edit_image_page_for Image.last
  end
  
  scenario "An artisan can add a primary cropping to an image" do
    # When I click the 'Add a Primary Cropping'
    click_link 'Add a Primary Cropping'
    
    # And I click Crop (1:1)
    click_link 'Crop (1:1)'
    
    # And I press the Add Cropping button,
    click_button 'Add Cropping'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my cropped image.
    within '.cropping_1' do
      page.should have_selector 'img'
    end
  end
  
  scenario "An artisan can add a secondary cropping to an image"
  scenario "An artisan can edit a cropping"
end