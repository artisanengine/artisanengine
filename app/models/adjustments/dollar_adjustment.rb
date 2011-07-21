class DollarAdjustment < Adjustment
  def amount_to_capture
    basis
  end
end