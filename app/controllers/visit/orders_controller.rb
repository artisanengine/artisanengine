module Visit
  class OrdersController < Visit::VisitController
    respond_to :html
    
    before_filter :order_cannot_be_empty, only: [ :edit, :update ]
    
    expose( :order )                { current_order }
    expose( :line_items )           { order.line_items }
    expose( :shipping_address )     { order.shipping_address }
    expose( :new_shipping_address ) { params[ :order ].try( :[], :shipping_address ) ? Address.new( params[ :order ][ :shipping_address ] ) : Address.new }
    expose( :new_billing_address )  { params[ :order ].try( :[], :billing_address ) ? Address.new( params[ :order ][ :billing_address ] ) : Address.new }
    
    # POST /checkout
    def update
      # Set frames.
      params[ :order ][ :shipping_address ][ :frame_id ] = current_frame.id
      params[ :order ][ :billing_address ][ :frame_id ]  = current_frame.id
      
      # Set billing attributes to shipping attributes if Shipping is Billing is set.
      params[ :order ][ :billing_address ] = params[ :order ][ :shipping_address ] if params[ :shipping_is_billing ]
      
      # Set order addresses.
      order.shipping_address = new_shipping_address
      order.billing_address  = new_billing_address
      @billing_errors        = params[ :shipping_is_billing ] ? false : true
      
      # Update order.
      if order.update_attributes( params[ :order ] )
        order.checkout! ? redirect_to( paypal_path ) : render( :edit )
      else
        render :edit
      end
    end
    
    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    # GET /update_state_select
    def update_state_select
      @country_code = params[ :country ]
      @type         = params[ :type ]
    end
    
    # ------------------------------------------------------------------
    private
    
    def order_cannot_be_empty
      redirect_to new_order_path unless line_items.any?
    end
  end
end