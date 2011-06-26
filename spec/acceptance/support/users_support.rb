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
  visit new_user_page
  fill_in_account_information( options )
  click_button 'Sign Up'
end

# ------------------------------------------------------------------
# User/Role/Domain Integration Helpers

def assume_role( role, options = {} )
  # Use the in_frame option for the domain, if there is one.
  domain = options[ :in_frame ] || 'example.com'
  
  if role == :visitor
    # Visitors are just anonymous users, so to assume their role just sign out.
    sign_out
  else
    # Directly create a user with assumed role in the frame matching the given domain.
    # Create the frame if it doesn't exist.
    user = Factory :user, role:  role.to_s.capitalize,
                          frame: find_or_create_frame( domain )
  end
  
  # Browse the found or created frame.
  browse_frame domain
  
  # Sign in as the user (unless we're simulating an anonymous user).
  sign_in_as user.email, user.password unless role == :visitor
end