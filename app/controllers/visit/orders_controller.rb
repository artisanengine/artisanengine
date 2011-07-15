module Visit
  class OrdersController < Visit::VisitController
    expose( :order ) { current_order }
    
    def new
    end
  end
end