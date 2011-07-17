module Manage
  class OrdersController < Manage::ManageController
    expose( :orders )           { current_frame.orders.where( "orders.status != 'new'" ) }
    expose( :order )            { orders.find_by_id_in_frame( params[ :id ] ) }
    expose( :patron )           { order.patron }
    expose( :shipping_address ) { order.shipping_address }
    expose( :billing_address )  { order.billing_address }
    expose( :line_items )       { order.line_items }
  end
end