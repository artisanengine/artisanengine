module Visit
  class MailFormsController < Visit::VisitController
    def donations
      # Set the current frame.
      frame = current_frame
      
      # Set the attributes.
      @donations_form = DonationsForm.new( params[ :donations_form ] )
      
      # Set the proper headers.
      @donations_form.to      = ENV[ "E-MAIL_HIJACKER" ] || frame.artisans.first.email
      @donations_form.subject = "You have received a donation request."
      
      # Deliver the form directly.
      if verify_recaptcha( model: @donations_form, message: 'Recaptcha Error' ) and @donations_form.deliver
        flash[ :notice ] = "Your submission was sent successfully!"
        redirect_to '/pages/donations'
      else
        flash.now[ :alert ] = "There were some invalid fields in your submission. Please correct them and try again."
        render '/visit/pages/donations', layout: 'pages'
      end
    end
    
    def press
      # Set the current frame.
      frame = current_frame
      
      # Set the attributes.
      @press_form = PressForm.new( params[ :press_form ] )
      
      # Set the proper headers.
      @press_form.to      = ENV[ "E-MAIL_HIJACKER" ] || frame.artisans.first.email
      @press_form.subject = "You have received a press inquiry."
      
      # Deliver the form directly.
      if verify_recaptcha( model: @press_form, message: 'Recaptcha Error' ) and @press_form.deliver
        flash[ :notice ] = "Your submission was sent successfully!"
        redirect_to '/pages/press-and-review'
      else
        flash.now[ :alert ] = "There were some invalid fields in your submission. Please correct them and try again."
        render '/visit/pages/press-and-review', layout: 'pages'
      end
    end
    
    def wholesale
      # Set the current frame.
      frame = current_frame

      # Set the attributes.
      @wholesale_form = WholesaleForm.new( params[ :wholesale_form ] )

      # Set the proper headers.
      @wholesale_form.to      = ENV[ "E-MAIL_HIJACKER" ] || frame.artisans.first.email
      @wholesale_form.subject = "You have received a wholesale inquiry."

      # Deliver the form directly.
      if verify_recaptcha( model: @wholesale_form, message: 'Recaptcha Error' ) and @wholesale_form.deliver
        flash[ :notice ] = "Your submission was sent successfully!"
        redirect_to '/pages/wholesale-inquiries'
      else
        flash.now[ :alert ] = "There were some invalid fields in your submission. Please correct them and try again."
        render '/visit/pages/wholesale-inquiries', layout: 'pages'
      end
    end
    
    def contact
      # Set the current frame.
      frame = current_frame

      # Set the attributes.
      @contact_form = ContactForm.new( params[ :contact_form ] )

      # Set the proper headers.
      @contact_form.to      = ENV[ "E-MAIL_HIJACKER" ] || frame.artisans.first.email
      @contact_form.subject = "You have received a contact inquiry."

      # Deliver the form directly.
      if verify_recaptcha( model: @contact_form, message: 'Recaptcha Error' ) and @contact_form.deliver
        flash[ :notice ] = "Your submission was sent successfully!"
        redirect_to '/pages/contact-us'
      else
        flash.now[ :alert ] = "There were some invalid fields in your submission. Please correct them and try again."
        render '/visit/pages/contact-us', layout: 'pages'
      end
    end
  end
end