require 'acceptance/acceptance_helper'

feature 'Automatic Blog Setup', %q{
  In order to expedite the process of starting my blog
  As an artisan
  I want a blog to be automatically created for me.
} do
  
  background do
    # Given I am signed in as an artisan,
    sign_in_as_artisan
  end
  
  scenario "A blog is automatically created when an artisan's frame is created" do
    # When I visit the manage blog page,
    visit manage_blog_page
    
    # Then I should see my blog.
    page.should have_content 'Test Frame Blog'
  end
end