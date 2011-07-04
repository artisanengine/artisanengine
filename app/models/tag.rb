class Tag < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :taggings, dependent: :destroy
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
end
