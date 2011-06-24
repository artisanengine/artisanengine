require 'acceptance/acceptance_helper'

feature 'User Authentication', %q{
  In order to prevent unauthenticated users from accessing sensitive information
  As an engineer
  I want to enforce authentication.
} do
  
  scenario "An unauthenticated user must sign in to access an authenticated resource"
  scenario "An authenticated user can access a resource for which he has permissions"
  scenario "An authenticated user cannot access a resource for which he does not have permissions"
end