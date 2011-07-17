require 'acceptance/acceptance_helper'

feature "View My Patrons", %q{
  In order to view and manage my patrons
  As an artisan
  I want to see all my patrons.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # Given I have three patrons,
    3.times { Patron.generate }
  
    # And I am on the manage patrons page,
    visit manage_patrons_page
  end
  
  scenario "An artisan can see all her patrons" do
    # Then I should see three patrons.
    page.should have_selector '.patron', count: 3
  end
end