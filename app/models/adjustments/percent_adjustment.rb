# A percent adjustment.
class PercentAdjustment < Adjustment
  
  # ------------------------------------------------------------------
  # Methods
  
  # PercentAdjustments capture their adjustable's price and modify it by
  # their basis.
  def amount_to_capture
    amount = adjustable.unadjusted_total * ( basis / 100 )
    amount = amount * -1 if promotion
  end

end