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

def sign_in_as_engineer
  # Sign in as the example engineer in the example frame.
  browse_frame 'example.com'
  sign_in_as   'reade@artisanengine.com', 'micagrl'
end

def sign_in_as_role( role, options )
  can_force_frame( options )
  
  # Create a user directly, since it's preferable to seeding with an engineer.
  # Assign it to the example frame by default, but allow overrides with the in_frame option.
  user = Factory :user, role: role.to_s.capitalize, 
                        frame: Frame.find_by_domain( options[ :in_frame ] || 'example.com' )
  
  # Sign in as the directly created user.
  sign_in_as user.email, user.password
end