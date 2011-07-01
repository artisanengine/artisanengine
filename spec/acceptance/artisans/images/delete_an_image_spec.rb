require 'acceptance/acceptance_helper'

feature 'Delete an Image', %q{
  In order to remove images from my gallery
  As an artisan
  I want to delete an image.
} do
  
  background do
    # Given I am logged in as an artisan,
    sign_in_as_artisan
    
    # And I have uploaded an image,
    Image.generate
    
    # And I am on the Image Gallery page,
    visit images_page
  end
  
  scenario "An artisan can delete an image" do
    # When I click the Delete link,
    within '.image' do
      click_link 'Delete'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see no images.
    page.should have_no_selector '.image'
  end
end