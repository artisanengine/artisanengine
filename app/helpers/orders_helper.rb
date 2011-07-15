module OrdersHelper
  def current_order
    if session[ :order_id ]
      order = Order.find( session[ :order_id ] )
      return order if order.new? or order.pending?
    end
  
    new_order            = Order.create! frame: current_frame
    session[ :order_id ] = new_order.id
    new_order
  end
end