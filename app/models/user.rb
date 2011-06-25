class User < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Authlogic
  
  acts_as_authentic do |config|
    # E-Mail only needs to validate as unique within the frame.
    config.merge_validates_uniqueness_of_email_field_options :scope => :frame_id
  end
  
  # ------------------------------------------------------------------
  # Validations
  
  # Authlogic already validates E-Mail and Password fields.
  validates_presence_of :first_name, :last_name, :frame
  
  # ------------------------------------------------------------------
  # Roles
  
  ROLES = %w( Engineer Artisan Patron )
end