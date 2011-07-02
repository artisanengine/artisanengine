# ------------------------------------------------------------------
# Paths

def engineer_sign_in_page
  '/develop/sign_in'
end

def engineer_sign_out_page
  '/develop/sign_out'
end

# ------------------------------------------------------------------
# Authentication

def sign_in_as_engineer( options = {} )  
  # Create an engineer as a convenience if no parameters are specified.
  if options[ :email ].nil? and options[ :password ].nil?
    engineer = Engineer.generate
    email    = engineer.email
    password = engineer.password
  else
    email    = options[ :email ]
    password = options[ :password ]
  end
  
  # Sign in as the engineer.
  visit engineer_sign_in_page
  
  fill_in 'E-Mail',   with: email
  fill_in 'Password', with: password
  click_button 'Sign In'
end