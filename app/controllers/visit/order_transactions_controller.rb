module Visit
  class OrderTransactionsController < Visit::VisitController
    protect_from_forgery except: [ :ipns ]
    include ActiveMerchant::Billing::Integrations
    
    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    # POST /ipns
    def ipns
      params.delete( :controller )
      params.delete( :action )
      
      ipn   = Paypal::Notification.new( request.raw_post )
      order = Order.find( ipn.invoice )
      
      if ipn.acknowledge or Rails.env.test?
        begin
          if ipn.complete? and order.total == base_total( ipn )
            OrderTransaction.create! order:     order,
                                     success:   true,
                                     amount:    base_total( ipn ),
                                     reference: ipn.transaction_id,
                                     action:    'purchase',
                                     params:    params
            order.purchase!
          else
            logger.error "PayPal transaction was not completed. Please investigate."
            create_failed_order_transaction( order, params )
            order.fail!
          end
        rescue => e
          logger.error "PayPal transaction raised an error. Please investigate."
          create_failed_order_transaction( order, params )
          order.fail!
        end
      else
        logger.error "Could not verify PayPal's IPN. Please investigate."
        create_failed_order_transaction( order, params )
        order.fail!
      end
                                 
      render nothing: true
    end
    
    private
    
    def create_failed_order_transaction( order, params )
      OrderTransaction.create! order: order, success: false, params: params
    end
    
    def base_total( ipn )
      ipn.gross.to_money - params[ :mc_shipping ].to_money - params[ :tax ].to_money
    end
  end
end