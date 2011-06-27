require 'acceptance/acceptance_helper'

feature 'Upload an Image', %q{
  In order to include my beautiful photography in pages and good listings
  As an artisan
  I want to upload an image.
} do
  
  background do
    # Given I am logged in as an artisan,
    assume_role :artisan
    
    # And I am on the new image page,
    visit new_image_page
  end
  
  scenario "An artisan can upload a valid image" do
    # When I add an image to the Image field,
    attach_file 'Image', test_image
    
    # And I click Upload,
    click_button 'Upload'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my image.
    page.should have_content 'anaura_bay.jpg'
  end
end