class Artisan < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :frame_id

  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Authentication
  
  devise :database_authenticatable, authentication_keys: [ :email, :frame_id ]
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of     :first_name, :last_name, :email, :password, :frame
  validates_confirmation_of :password
  validates_format_of       :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end