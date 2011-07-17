module Visit
  class LineItemsController < Visit::VisitController
    respond_to :html
    
    expose( :order )     { current_order }
    expose( :line_item ) { order.line_item_from( params[ :line_item ][ :variant_id ] ) }
    
    def create
      line_item.save
      redirect_to new_order_path
    end
    
    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    def update_quantities
      params[ :line_item ].each do |key, value|
        order.line_items.find( key ).update_attributes quantity: value
      end

      redirect_to new_order_path
    end
  end
end