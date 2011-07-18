module Visit
  class PatronsController < Visit::VisitController
    def subscribe
      patron            = Patron.find_or_initialize_by_email( params[ :email ] )
      patron.frame      = current_frame
      patron.subscribed = true
      
      flash[ :subscribe_notice ] = patron.save ? 'Thank you for subscribing!' : 'You have entered an invalid E-Mail.'
      redirect_to :back
    end
  end
end