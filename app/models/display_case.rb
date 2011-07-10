class DisplayCase < ActiveRecord::Base
  attr_accessible :name, :good_id, :display_case_id
  
  has_friendly_id :name, use_slug: true, scope: :frame
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_update  :ensure_not_featured_case
  before_destroy :ensure_not_featured_case
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :collects, dependent: :destroy
  has_many   :goods,    through: :collects
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
  
  # ------------------------------------------------------------------
  private
  
  def ensure_not_featured_case
    if name == "Featured" or name_was == "Featured"
      errors.add( :base, "Cannot edit or destroy the Featured case." )
      return false
    end
  end
end
