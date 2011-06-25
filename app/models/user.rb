class User < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Devise
  
  devise :database_authenticatable
  
  # ------------------------------------------------------------------
  # Validations
  
  # Authlogic already validates E-Mail and Password fields.
  validates_presence_of :first_name, :last_name, :frame
  
  # ------------------------------------------------------------------
  # Roles
  
  ROLES = %w( Engineer Artisan Patron )
end