class Tagging < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :tag, :taggable
end
