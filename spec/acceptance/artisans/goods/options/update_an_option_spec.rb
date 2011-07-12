require 'acceptance/acceptance_helper'

feature 'Update an Option', %q{
  In order to change the display of variations of my good
  As an artisan
  I want to update an option.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
    
    # And I have created a good,
    @good = Good.generate name: 'Freeze Ray'
    
    # And my good has two additional options,
    @good.options << Option.spawn( name: 'Destructiveness', default_value: 'Low' )
    @good.options << Option.spawn( name: 'Horribleness',    default_value: 'High' )
    
    # And I am on the edit good page for the good,
    visit edit_good_page_for 'Freeze Ray'
    
    # And I have clicked the Edit link for Destructiveness,
    within '.option', text: 'Destructiveness' do
      click_link 'Edit'
    end
  end
  
  scenario "An artisan can update an option with valid attributes" do
    # When I fill in valid information for the updated option,
    fill_in 'Name', with: 'Destructive Capacity'
    
    # And I click Update Option,
    click_button 'Update Option'
    
    # Then I should see a notice,
    page_should_have_notice
    
    # And I should see my new option.
    page.should have_content 'Destructive Capacity'
  end
  
  scenario "An artisan cannot update an option with invalid attributes" do
    # When I fill in invalid information for the updated option,
    fill_in 'Name', with: ''
    
    # And I click Update Option,
    click_button 'Update Option'
    
    # Then I should see an alert,
    page_should_have_error
    
    # And my option's attributes should not change.
    @good.options[1].name.should == 'Destructiveness'
  end
end