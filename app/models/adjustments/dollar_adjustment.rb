# A dollar adjustment is the most basic kind of adjustment - it simply
# applies a dollar amount to the cost of whatever it adjusts.
class DollarAdjustment < Adjustment
  
  # ------------------------------------------------------------------
  # Methods
  
  # DollarAdjustments simply pass back whatever was passed 
  # into them.
  def amount_to_capture
    basis
  end

end