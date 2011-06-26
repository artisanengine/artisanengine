# ------------------------------------------------------------------
# Paths

def new_user_page
  '/users/new'
end

# ------------------------------------------------------------------
# Actions

def fill_in_account_information( options = {} )
  # Options:
  first_name            = options[ :first_name ]            || Faker::Name.first_name
  last_name             = options[ :last_name ]             || Faker::Name.last_name
  email                 = options[ :email ]                 || Faker::Internet.email
  password              = options[ :password ]              || 'password'
  password_confirmation = options[ :password_confirmation ] || password
  
  # Action:
  fill_in 'First Name',            with: first_name
  fill_in 'Last Name',             with: last_name
  fill_in 'E-Mail',                with: email
  fill_in 'Password',              with: password
  fill_in 'Password Confirmation', with: password
end

def create_user( options = {} ) 
  # Action:
  visit new_user_page
  fill_in_account_information( options )
  click_button 'Sign Up'
end

def assume_role( role, domain )
  
end

# Helper method to allow other integration methods to force the user.
def can_force_user( options = {} )
  become_user( options[ :as ] ) if options[ :as ]
end