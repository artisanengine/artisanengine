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
  password   = options[ :password ]   || 'testuser'
  role       = options[ :role ]       || 'Artisan'
  email      = options[ :email ]      || Faker::Internet.email
  
  # Action:
  visit new_user_page
  
  select  frame,                   from: 'Frame'
  fill_in 'First Name',            with: first_name
  fill_in 'Last Name',             with: last_name
  fill_in 'E-Mail',                with: email
  fill_in 'Password',              with: password
  fill_in 'Password Confirmation', with: password
  select  role,                    from: 'Role'
  
  click_button 'Create User'
end