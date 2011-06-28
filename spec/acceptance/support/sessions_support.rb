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
  fill_in 'E-Mail',   with: email
  fill_in 'Password', with: password
  click_button 'Sign In'
end

def sign_out
  visit sign_out_page
end