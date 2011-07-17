class OrderMailer < ActionMailer::Base
  default from: "noreply@artisanengine.com"

  def patron_order_confirmation_email( order, frame )
    @frame      = frame
    @order      = order
    @patron     = order.patron
    @line_items = order.line_items

    mail( from:    Setting.get_or_set( @frame, "E-Mail Sender", "noreply@#{ @frame.domain }" ),
          to:      order.patron.email,
          subject: "Thank you for your order!" )
  end
  
  def artisan_order_confirmation_email( order, frame )
    @frame      = frame
    @order      = order
    @patron     = order.patron
    @line_items = order.line_items

    mail( from:    "noreply@artisanengine.com",
          to:      "frame.artisan.email",
          subject: "Thank you for your order!" )
  end
end
