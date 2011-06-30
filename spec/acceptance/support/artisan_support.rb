# ------------------------------------------------------------------
# Paths

def new_artisan_page
  '/develop/artisans/new'
end

def artisan_sign_in_page
  '/manage/sign_in'
end

def artisan_sign_out_page
  '/manage/sign_out'
end

# ------------------------------------------------------------------
# Authentication

def sign_in_as_artisan( options = {} )
  frame = options[ :in_frame ]
  
  # Create an artisan as a convenience if no parameters are specified.
  # Use the test frame if no frame is specified.
  if options[ :email ].nil? and options[ :password ].nil?
    artisan  = frame ? Artisan.generate( frame: frame ) : Artisan.generate 
    email    = artisan.email
    password = artisan.password
  else
    email    = options[ :email ]
    password = options[ :password ]
  end
  
  # Browse the test frame if no other frame is specified.
  frame ? browse_frame( frame ) : browse_frame
    
  visit artisan_sign_in_page
  fill_in 'E-Mail',   with: email
  fill_in 'Password', with: password
  click_button 'Sign In'
end