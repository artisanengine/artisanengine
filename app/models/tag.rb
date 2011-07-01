class Tag < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :taggings
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
end
