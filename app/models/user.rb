class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation

  include ArtisanEngine::DynamicAttributePermissions   # Authorization
  
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
  validates_uniqueness_of   :email, :scope => :frame_id
  validates_format_of       :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # ------------------------------------------------------------------
  # Roles
  
  ROLES = %w( Artisan Patron )
end