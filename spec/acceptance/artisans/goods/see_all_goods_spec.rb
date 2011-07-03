require 'acceptance/acceptance_helper'

feature 'See All Goods', %q{
  In order to get an overview of my catalog
  As an artisan
  I want to see all my goods.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created three goods,
    3.times { Good.generate }
    
    # And I am on the manage goods page,
    visit manage_goods_page
  end
  
  scenario "An artisan can see all her goods" do
    # Then I should see my goods.
    page.should have_selector '.good', count: 3
  end
end