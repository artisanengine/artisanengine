module Visit
  class LineItemsController < Visit::VisitController
    respond_to :html
    
    expose( :order )      { current_order }
    expose( :line_items ) { order.line_items }
    expose( :line_item )
    
    def create
      line_item.save
      respond_with line_item, location: new_order_path
    end
  end
end