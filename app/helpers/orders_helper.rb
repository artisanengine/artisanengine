module OrdersHelper
  def current_order
    if session[ :order_id ]
      begin
        order = Order.find( session[ :order_id ] )
        return order if order and ( order.new? or order.pending? )
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