module Manage
  class OrdersController < Manage::ManageController
    expose( :orders )             { current_frame.orders.except_new.order( "orders.id_in_frame DESC" ) }
    expose( :order )              { orders.find_by_id_in_frame( params[ :id ] ) }
    
    expose( :patron )             { order.patron }
    expose( :shipping_address )   { order.shipping_address }
    expose( :billing_address )    { order.billing_address }
    expose( :line_items )         { order.line_items }
    expose( :order_transactions ) { order.order_transactions }
  end
end