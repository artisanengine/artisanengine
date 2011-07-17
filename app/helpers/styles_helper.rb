module StylesHelper
  def fulfillment_class( order )
    case order.fulfillment_status
    when "Fulfilled"
      'complete'
    when "Partially Fulfilled"
      'partial'
    when "Not Fulfilled"
      'incomplete'
    end
  end
end