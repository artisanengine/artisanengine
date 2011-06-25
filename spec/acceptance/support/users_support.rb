# ------------------------------------------------------------------
# Paths

def new_user_page
  '/users/new'
end

# ------------------------------------------------------------------
# Actions

def create_user( options = {} )
  # Options:
  frame      = options[ :frame ]      || 'Example Frame'
  first_name = options[ :first_name ] || Faker::Name.first_name
  last_name  = options[ :last_name ]  || Faker::Name.last_name
  role       = options[ :role ]       || 'Artisan'
  email      = options[ :email ]      || Faker::Internet.email
  
  # Action:
  select  frame,                   from: 'Frame'
  fill_in 'First Name',            with: first_name
  fill_in 'Last Name',             with: last_name
  fill_in 'E-Mail',                with: email
  fill_in 'Password',              with: 'testuser'
  fill_in 'Password Confirmation', with: 'testuser'
  select  role,                    from: 'Role'
end