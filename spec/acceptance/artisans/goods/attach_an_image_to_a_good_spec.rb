require 'acceptance/acceptance_helper'

feature 'Attach an Image to a Good', %q{
  In order to display images of my goods to patrons
  As an artisan
  I want to attach an image to a good.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good,
    Good.generate name: 'Freeze Ray'
    
    # And I have created an image,
    Image.generate image: anaura_bay_image
    
    # And I am on the Edit Good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end
  
  scenario "An artisan can attach an existing image to a good" do
    # When I click Attach an Existing Image,
    click_link 'Attach an Existing Image'
    
    # And I click the Attach button an an existing Image,
    within '.image' do
      click_button 'Attach'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my good and my image.
    page.should have_content 'Freeze Ray'
    within '#images' do
      page.should have_selector 'img'
    end
  end
end