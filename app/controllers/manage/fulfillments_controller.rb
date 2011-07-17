module Manage
  class FulfillmentsController < Manage::ManageController
    respond_to :html
    
    expose( :orders )       { current_frame.orders }
    expose( :order )        { orders.find_by_id_in_frame( params[ :order_id ] ) }
    expose( :fulfillment )
  
    def create
      fulfillment.order = order
      
      flash[ :notice ] = "Fulfillment was successfully created." if fulfillment.save
      respond_with :manage, order, fulfillment, location: manage_order_path( order )
    end
  end
end