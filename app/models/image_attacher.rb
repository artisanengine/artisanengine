class ImageAttacher < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Callbacks
  
  before_create         :set_position
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to            :image
  belongs_to            :imageable, polymorphic: true
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :image, :imageable
  validates_associated  :image
  
  # ------------------------------------------------------------------
  # Scopes
  
  scope :in_order,       order( "image_attachers.position ASC" )
  
  # ------------------------------------------------------------------
  private
  
  def set_position
    imageable.image_attachers.any? ? assume_lowest_position : self.position = 1
  end
  
  def assume_lowest_position
    lowest_attacher = imageable.image_attachers.in_order.last
    self.position   = lowest_attacher.position + 1
  end
end
