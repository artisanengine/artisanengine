# Engineers have full administrative privileges for the whole application.
class Engineer < ActiveRecord::Base
  attr_accessible :email, :password

  # ------------------------------------------------------------------
  # Authentication
  
  devise :database_authenticatable
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of     :email, :password
  validates_confirmation_of :password
  validates_format_of       :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end