class Tag < ActiveRecord::Base
  attr_accessible :name
  
  has_friendly_id :name, use_slug: true, scope: :frame
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :taggings, dependent: :destroy
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
end
