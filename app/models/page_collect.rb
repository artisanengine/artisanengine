class PageCollect < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :page
  belongs_to :page_collection
  
  # ------------------------------------------------------------------
  # Positioning
  
  include RankedModel
  ranks :display_order, with_same: :page_collection_id
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :page, :page_collection
end
