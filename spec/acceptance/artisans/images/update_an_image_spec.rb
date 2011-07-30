require 'acceptance/acceptance_helper'

feature 'Update an Image', %q{
  In order to update image details for images in my gallery
  As an artisan
  I want to update an image.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have uploaded an image,
    Image.generate name: 'Old Name'
    
    # And I am on the edit image page for the image,
    visit edit_image_page_for Image.last
  end
  
  scenario "An artisan can update an image" do
    # When I fill in Name with 'New Name'
    fill_in 'Name', with: 'New Name'
    
    # And I click Update Image
    click_button 'Update Image'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see the new name.
    page.should have_content 'New Name'
  end
end
