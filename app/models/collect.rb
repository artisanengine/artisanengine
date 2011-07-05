class Collect < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :good
  belongs_to :display_case
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :good, :display_case
end
