require 'acceptance/acceptance_helper'

feature 'Remove an Image from a Good', %q{
  In order to manage my goods' images
  As an artisan
  I want to remove an image from a good.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good with an image,
    g         = Good.generate name: 'Freeze Ray'
    g.images << Image.spawn
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end
  
  scenario "An artisan can remove an image from a good" do
    # When I click the Image Attacher's Remove link,
    within '.image_attacher' do
      click_link 'Remove'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see no images.
    within '#good_images' do
      page.should have_no_selector '.image'
    end
  end
end