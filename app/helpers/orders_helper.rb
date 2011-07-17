module OrdersHelper
  def current_order
    if session[ :order_id ]
      begin
        order = Order.find( session[ :order_id ] )
        
        # Don't bother returning an order if it isn't new or pending,
        # since a visitor can't edit it at that point anyway.
        return order if order and ( order.new? or order.pending? )
      
      # In case the order has been cleared out but the ID is still in the
      # session, give them a new order.
      rescue ActiveRecord::RecordNotFound
        return create_new_order
      end
    end
    
    create_new_order
  end
  
  def create_new_order
    new_order            = Order.create! frame: current_frame
    session[ :order_id ] = new_order.id
    new_order
  end
end