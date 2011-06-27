class Image < ActiveRecord::Base
  attr_accessible :image
  image_accessor  :image
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
end