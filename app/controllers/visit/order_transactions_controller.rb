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
      
      if Rails.env.test? or ipn.acknowledge                           # Verify authenticity with PayPal.
        begin
          if ipn.complete? and order.unadjusted_total == base_total( ipn )  # Verify the amount is correct.
            OrderTransaction.create! order:           order,                # Log the transaction details.
                                     success:         true,
                                     amount:          ipn.gross,
                                     reference:       ipn.transaction_id,
                                     action:          'purchase',
                                     params:          params,
                                     payment_service: 'PayPal WPS'
            
            unless params[ :mc_shipping ].nil? or params[ :mc_shipping ].to_money.zero?
              DollarAdjustment.create! message: "PayPal-Calculated Shipping", 
                                       basis: params[ :mc_shipping ],
                                       adjustable:  order
            end
            
            unless params[ :tax ].nil? or params[ :tax ].to_money.zero?
              DollarAdjustment.create! message: "PayPal-Calculated Tax", 
                                       basis: params[ :tax ],
                                       adjustable:  order
            end
            
            unless params[ :mc_fee ].nil? or params[ :mc_fee ].to_money.zero?
              DollarAdjustment.create! message: "PayPal Transaction Fee", 
                                       basis: "-#{ params[ :mc_fee ] }",
                                       adjustable:  order
            end
            
            if order.purchase!                                            # Order in!
              OrderMailer.patron_order_confirmation_email( order, current_frame ).deliver
              OrderMailer.artisan_order_receipt_email( order, current_frame ).deliver
            end
          else
            logger.error "PayPal transaction was not completed. Please investigate."
            create_failed_order_transaction( order, ipn, params )
            order.fail! unless order.purchased?
          end
        rescue => e
          logger.error "An error occurred while handling a PayPal IPN. Please investigate."
          create_failed_order_transaction( order, ipn, params )
          order.fail! unless order.purchased?
        end
      else
        logger.error "Could not verify PayPal's IPN. Please investigate."
        create_failed_order_transaction( order, ipn, params )
        order.fail! unless order.purchased?
      end
                                 
      render nothing: true
    end
    
    private
    
    # Log a failed IPN.
    def create_failed_order_transaction( order, ipn, params )
      OrderTransaction.create! order: order, amount: ipn.gross, success: false, params: params, payment_service: 'PayPal WPS'
    end
    
    # Get the total of the IPN before tax and shipping to check against
    # the order total.
    def base_total( ipn )
      ipn.gross.to_money - params[ :mc_shipping ].to_money - params[ :tax ].to_money
    end
  end
end