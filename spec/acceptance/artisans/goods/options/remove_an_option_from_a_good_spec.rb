require 'acceptance/acceptance_helper'

feature 'Add an Option to a Good', %q{
  In order to reduce the different variations of my good
  As an artisan
  I want to remove an option to my good.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good,
    good = Good.generate name: 'Freeze Ray'
    
    # And my good has two additional options,
    good.options << Option.spawn( name: 'Destructiveness', default_value: 'Low' )
    good.options << Option.spawn( name: 'Horribleness',    default_value: 'High' )
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
  end
  
  scenario "An artisan can delete an option from a good" do
    # When I click the Delete link for the Horribleness option,
    within '.option', text: 'Horribleness' do
      click_link 'Delete'
    end
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should not see the option.
    page.should have_no_content 'Horribleness'
  end
end
  