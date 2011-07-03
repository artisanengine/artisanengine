class Variant < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :good
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :good
end
