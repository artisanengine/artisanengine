require 'acceptance/acceptance_helper'

feature "View A Patron's Details", %q{
  In order to view and manage my patrons
  As an artisan
  I want to see a patron's details.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And there is a purchased order (creates a patron and two addresses),
    order  = Factory :purchased_order
    patron = order.patron
    
    # And I am on the patron details page for the patron,
    visit patron_details_page_for( patron.id )
  end
  
  scenario "An artisan can view an patron's details" do
    patron = Patron.last
    
    # Then I should see the patron's full name,
    page.should have_content "#{ patron.first_name } #{ patron.last_name }"
    
    # And I should see the patron's E-Mail,
    page.should have_content patron.email
    
    # And I should see the patron's subscription status,
    page.should have_content 'Not Subscribed'
    
    # And I should see one order,
    page.should have_selector '.order', count: 1
    
    # And I should see the patron's addresses,
    page.should have_selector '.address', count: 2
  end
end