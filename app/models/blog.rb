class Blog < ActiveRecord::Base
  attr_accessible :name
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
end