module Visit
  class OrderTransactionsController < Visit::VisitController
    protect_from_forgery except: [ :ipns ]
    
    include ActiveMerchant::Billing::Integrations
    
    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    # POST /ipns
    def ipns
      
      # Params are getting logged, and we don't care about these.
      params.delete( :controller )
      params.delete( :action )
      
      ipn   = Paypal::Notification.new( request.raw_post )            # Use ActiveMerchant's IPN parser.
      order = Order.find( ipn.invoice )                               # Gotta have an order to check against.
      
      if ipn.acknowledge or Rails.env.test?                           # Verify authenticity with PayPal.
        begin
          if ipn.complete? and order.total == base_total( ipn )       # Verify the amount is correct.
            OrderTransaction.create! order:           order,          # Log the transaction details.
                                     success:         true,
                                     amount:          base_total( ipn ),
                                     reference:       ipn.transaction_id,
                                     action:          'purchase',
                                     params:          params,
                                     payment_service: 'PayPal WPS'
            order.purchase!                                           # Order in!
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
    
    # Log a failed IPN.
    def create_failed_order_transaction( order, params )
      OrderTransaction.create! order: order, success: false, params: params, payment_service: 'PayPal WPS'
    end
    
    # Get the total of the IPN before tax and shipping to check against
    # the order total.
    def base_total( ipn )
      ipn.gross.to_money - params[ :mc_shipping ].to_money - params[ :tax ].to_money
    end
  end
end