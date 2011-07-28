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
  
  scenario "An artisan can add a primary cropping to an image", js: true, js_driver: :selenium do
    # When I click the 'Add a Primary Cropping'
    click_link 'Add a Primary Cropping'
    
    # And I click Crop (1:1)
    click_link 'Crop (1:1)'
    
    # And I press the Add Cropping button,
    click_button 'Add Cropping'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And my image should be cropped,
    Image.last.primary_cropping.should_not be_nil
    
    # And I should see my cropped image.
    within '.primary_cropping' do
      page.should have_selector 'img'
    end
  end
  
  scenario "An artisan can add a secondary cropping to an image", js: true, js_driver: :selenium do
    # When I click the 'Add a Secondary Cropping'
    click_link 'Add a Secondary Cropping'
    
    # And I click Crop (16:9)
    click_link 'Crop (16:9)'
    
    # And I press the Add Cropping button,
    click_button 'Add Cropping'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And my image should be cropped,
    Image.last.secondary_cropping.should_not be_nil
    
    # And I should see my cropped image.
    within '.secondary_cropping' do
      page.should have_selector 'img'
    end
  end
  
  scenario "An artisan can edit a cropping", focus: true, js: true, js_driver: :selenium do
    # When I click the 'Add a Primary Cropping'
    click_link 'Add a Primary Cropping'
    
    # And I click Crop (1:1)
    click_link 'Crop (1:1)'
    
    # And I press the Add Cropping button,
    click_button 'Add Cropping'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I store the crop values,
    cropping = Image.last.primary_cropping
    
    # And when I click the Edit Primary Cropping link,
    click_link 'Edit Primary Cropping'
    
    # And I click Crop (16:9)
    click_link 'Crop (16:9)'
    
    # And I press the Add Cropping button,
    click_button 'Add Cropping'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And my crop values should have changed.
    Image.last.primary_cropping.should_not == cropping
  end
end