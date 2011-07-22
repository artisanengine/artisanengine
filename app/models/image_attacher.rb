# ImageAttachers are a join model that connects images with other
# models. They can be put in a display order for sorting/organizing.
class ImageAttacher < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Positioning
  
  include RankedModel
  ranks :display_order, with_same: [ :imageable_type, :imageable_id ]
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to            :image
  belongs_to            :imageable, polymorphic: true
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :image, :imageable
  validates_associated  :image
end
