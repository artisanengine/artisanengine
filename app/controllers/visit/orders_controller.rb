module Visit
  class OrdersController < Visit::VisitController
    respond_to :html
    
    expose( :order )                { current_order }
    expose( :line_items )           { order.line_items }
    expose( :shipping_address )     { order.shipping_address }
    expose( :new_shipping_address ) { order.build_shipping_address }
    expose( :new_billing_address )  { order.build_billing_address }
    
    def update
      # Copy shipping address parameters to billing address if Shipping is Billing was checked.
      params[ :order ][ :billing_address_attributes ] = params[ :order ][ :shipping_address_attributes ] if params[ :shipping_is_billing ]
      
      # Set the address frames.
      params[ :order ][ :billing_address_attributes ][ :frame_id ]  = current_frame.id
      params[ :order ][ :shipping_address_attributes ][ :frame_id ] = current_frame.id
      
      order.checkout! if order.update_attributes( params[ :order ] )
      respond_with order, location: paypal_path
    end
  end
end