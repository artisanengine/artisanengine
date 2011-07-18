require 'acceptance/acceptance_helper'

feature "Subscribe to the Mailing List", %q{
  In order to get updates and special offers from the artisan
  As a visitor
  I want to subscribe to the mailing list.
} do
  
  background do
    # Given I am on the home page,
    browse_frame 'ae.test'
    visit '/'
  end
  
  scenario "A visitor can subscribe to the mailing list with a valid E-Mail" do
    # And I fill in a valid E-Mail address and click Subscribe
    within '#subscribe' do
      fill_in 'email', with: 'test@example.com'
      click_button 'Subscribe'
    end
    
    # Then I should be on the page that I subscribed from,
    page.current_path.should == '/'
    
    # And I should see a confirmation message in the subscription box
    within '#subscribe' do
      page.should have_content "Thank you"
    end
    
    # And there should be a new subscribed patron with the given E-Mail address
    patron = Patron.last
    patron.email.should == 'test@example.com'
    patron.should be_subscribed
  end
  
  scenario "A patron cannot subscribe to the mailing list without a valid E-Mail" do
    # When I fill in an invalid E-Mail address and click Join
    within '#subscribe' do
      fill_in 'email', with: 'bogus.email.@waaa'
      click_button 'Subscribe'
    end
    
    # Then I should be on the page that I subscribed from
    page.current_path.should == '/'
    
    # And I should see an alert message in the subscription box
    within '#subscribe' do
      page.should have_content 'invalid'
    end
    
    # And there should be no new patrons.
    Patron.count.should == 0
  end
end