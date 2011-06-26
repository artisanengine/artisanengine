# ------------------------------------------------------------------
# Paths

def sign_in_page
  '/sign_in'
end

def sign_out_page
  '/sign_out'
end

# ------------------------------------------------------------------
# Actions

def sign_in_as( email, password )
  visit sign_in_page
  fill_in 'E-Mail', with: email
  fill_in 'Password', with: password
  click_button 'Sign In'
end

def sign_out
  visit sign_out_page
end

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
                          frame: Frame.find_by_domain( domain ) || Factory( :frame, domain: domain )
  end
  
  # Browse the found or created frame.
  browse_frame domain
  
  # Sign in as the user.
  sign_in_as user.email, user.password unless role == :visitor
end