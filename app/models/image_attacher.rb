class ImageAttacher < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :image
  belongs_to :imageable, polymorphic: true
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :image, :imageable
end
