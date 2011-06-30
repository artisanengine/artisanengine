require 'acceptance/acceptance_helper'

feature 'Automatic Blog Setup', %q{
  In order to expedite the process of starting my blog
  As an artisan
  I want a blog to be automatically created for me.
} do
  
  scenario "A blog is automatically created when an artisan's frame is created" do
    # Given a frame has been created,
    Frame.generate name: 'Peggy Skemp Jewelry', domain: 'peggyskemp.dev'
    
    # And I am signed in as an artisan,
    sign_in_as_artisan in_frame: 'peggyskemp.dev'
    
    # When I visit the manage blog page,
    visit manage_blog_page
    
    # Then I should see my blog.
    page.should have_content 'Peggy Skemp Jewelry Blog'
  end
end