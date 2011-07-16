module Visit
  class OrdersController < Visit::VisitController
    respond_to :html
    
    expose( :order )                { current_order }
    expose( :new_shipping_address ) { order.build_shipping_address }
    expose( :new_billing_address )  { order.build_billing_address }
    
    def update
      params[ :order ][ :billing_address_attributes ] = params[ :order ][ :shipping_address_attributes ] if params[ :shipping_is_billing ]
      
      order.checkout! if order.update_attributes( params[ :order ] )
      respond_with order, location: paypal_path
    end
  end
end