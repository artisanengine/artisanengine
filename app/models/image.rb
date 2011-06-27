class Image < ActiveRecord::Base
  attr_accessible :image
  image_accessor  :image
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :image, :frame
  validates_property    :format, :of => :image, :in => [ :jpg, :jpeg, :png, :gif ]
  
end