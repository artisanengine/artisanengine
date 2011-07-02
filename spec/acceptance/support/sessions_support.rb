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

def sign_out
  visit sign_out_page
end