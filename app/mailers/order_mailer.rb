class OrderMailer < ActionMailer::Base
  default from: "noreply@artisanengine.com"

  def patron_order_confirmation_email( order, frame )
    @frame      = frame
    @order      = order
    @patron     = order.patron
    @line_items = order.line_items

    mail( from:    Setting.get_or_set( @frame, "E-Mail Sender", "noreply@#{ @frame.domain }" ),
          to:      @patron.email,
          subject: "Thank you for your order!" )
  end
  
  def artisan_order_receipt_email( order, frame )
    @frame      = frame
    @order      = order
    @patron     = order.patron
    @line_items = order.line_items

    mail( from:    "noreply@artisanengine.com",
          to:      "frame.artisan.email",
          subject: "You have received an order!" )
  end
  
  def patron_fulfillment_confirmation_email( fulfillment, frame )
    @frame        = frame
    @fulfillment  = fulfillment
    @patron       = fulfillment.order.patron
    @line_items   = fulfillment.line_items

    mail( from:    Setting.get_or_set( @frame, "E-Mail Sender", "noreply@#{ @frame.domain }" ),
          to:      @patron.email,
          subject: "Your order has shipped!" )
  end
end
