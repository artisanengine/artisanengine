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
          if ipn.complete? and order.line_total == ipn.gross.to_money # Verify the amount is correct.
            OrderTransaction.create! order:           order,          # Log the transaction details.
                                     success:         true,
                                     amount:          ipn.gross,
                                     reference:       ipn.transaction_id,
                                     action:          'purchase',
                                     params:          params,
                                     payment_service: 'PayPal WPS'
            
            unless params[ :mc_shipping ].to_money.zero?
              Adjustment.create! message: "PayPal-Calculated Shipping", 
                                      amount: params[ :mc_shipping ],
                                      order:  order
            end
            
            unless params[ :tax ].to_money.zero?
              Adjustment.create! message: "PayPal-Calculated Tax", 
                                      amount: params[ :tax ],
                                      order:  order
            end
            
            Adjustment.create! message: "PayPal Transaction Fee", 
                                    amount: "-#{ params[ :mc_fee ] }",
                                    order:  order
            
            if order.purchase!                                            # Order in!
              OrderMailer.patron_order_confirmation_email( order, current_frame ).deliver
              OrderMailer.artisan_order_receipt_email( order, current_frame ).deliver
            end
          else
            logger.error "PayPal transaction was not completed. Please investigate."
            create_failed_order_transaction( order, params )
            order.fail!
          end
        #rescue => e
        #  logger.error "An error occurred while handling a PayPal IPN. Please investigate."
        #  create_failed_order_transaction( order, params )
        #  order.fail!
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