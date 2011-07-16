module Visit
  class OrderTransactionsController < Visit::VisitController
    protect_from_forgery except: [ :ipns ]
    include ActiveMerchant::Billing::Integrations
    
    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    # POST /ipns
    def ipns
      ipn   = Paypal::Notification.new( request.raw_post )
      order = Order.find( ipn.invoice )
      
      if ipn.acknowledge or Rails.env.test?
        begin
          if ipn.complete?
            OrderTransaction.create! order: order,
                                     success: true
            order.purchase!
          else
            logger.error "PayPal transaction was not completed. Please investigate."
            create_failed_order_transaction( order )
            order.fail!
          end
        rescue => e
          logger.error "PayPal transaction raised an error. Please investigate."
          create_failed_order_transaction( order )
          order.fail!
        end
      else
        logger.error "Could not verify PayPal's IPN. Please investigate."
        create_failed_order_transaction( order )
        order.fail!
      end
                                 
      render nothing: true
    end
    
    private
    
    def create_failed_order_transaction( order )
      OrderTransaction.create! order: order, success: false
    end
  end
end