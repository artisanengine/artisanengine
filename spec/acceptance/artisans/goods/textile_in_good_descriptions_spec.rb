require 'acceptance/acceptance_helper'

feature 'Textile in Good Descriptions', %q{
  In order to spice up my good descriptions
  As an artisan
  I want to use Textile in my good descriptions.
} do
  
  background do
    # Given I have created a good with a Textiled description,
    Good.generate name: 'Bolder Than Thou', description: 'A *bold* good.'
  end
  
  scenario "An artisan can use Textile in his good descriptions" do
    # When I visit the show good page for the good,
    visit good_page_for 'Bolder Than Thou'
    
    # Then I should see the Textiled good description.
    page.should have_selector 'strong', text: 'bold'
  end
end