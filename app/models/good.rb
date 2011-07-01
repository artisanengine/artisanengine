class Good < ActiveRecord::Base
  attr_accessible :name, :description
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
end
