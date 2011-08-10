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
      if verify_recaptcha( model: @donations_form, message: 'Invalid reCAPTCHA.' ) and @donations_form.deliver
        flash[ :notice ] = "Your submission was received."
        redirect_to '/pages/donations'
      else
        flash[ :notice ] = "Your submission was not received."
        render '/visit/pages/donations', layout: 'pages'
      end
    end
  end
end