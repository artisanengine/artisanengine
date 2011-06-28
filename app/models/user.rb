class User < ActiveRecord::Base
  include ArtisanEngine::DynamicAttributePermissions
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Authentication
  
  devise :database_authenticatable, authentication_keys: [ :email, :frame_id ]
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of   :first_name, :last_name, :email, :frame
  validates_uniqueness_of :email, :scope => :frame_id
  validates_format_of     :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # ------------------------------------------------------------------
  # Roles
  
  ROLES = %w( Artisan Patron )
end