class Promotion < ActiveRecord::Base
  DISCOUNT_TYPES   = { "Percent Off" => "PercentAdjustment" }
  DISCOUNT_TARGETS = [ "Entire Order" ]
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :promotional_code, :discount_amount, :discount_type, :discount_target
  
  # ------------------------------------------------------------------
  # Class Methods
  
  # Checks if a promotion exists and returns it if so. Otherwise, returns false.
  def self.valid_promotion?( frame, code )
    Promotion.exists?( frame_id: frame.id, promotional_code: code ) ? 
      Promotion.where( frame_id: frame.id, promotional_code: code ).first :
      false
  end
  
  # ------------------------------------------------------------------
  # Instance Methods
  
  # Figures out what adjustment class it is based on its discount type.
  def adjustment_class
    DISCOUNT_TYPES[ discount_type ].constantize
  end
end
