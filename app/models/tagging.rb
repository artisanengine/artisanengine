# A tagging joins a tag with another model to create arbitrary organizational
# structures.
class Tagging < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :tag, :taggable
end
