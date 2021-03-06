# Collects are a join model that connects goods with display cases. They
# can be sorted into a display order for display/organization purposes.
class Collect < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :good
  belongs_to :display_case
  
  # ------------------------------------------------------------------
  # Positioning
  
  include RankedModel
  ranks :display_order, with_same: :display_case_id
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :good, :display_case
end
