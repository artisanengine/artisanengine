# Logic related to the current "frame," which encapsulates an artisan's
# site.
module FramesHelper
  
  # Retrieve the cached frame or set a new one.
  def current_frame
    @current_frame ||= set_frame
  end
  
  # Retrieve the current frame's Google Analytics account credentials.
  def google_analytics_account
    @google_analytics_account ||= Setting.get_or_set( current_frame, 'Google Analytics' )
  end
  
  # Retrieve the current frame's Password Protected status.
  def password_protected_frame?
    @password_protected ||= Setting.get_or_set( current_frame, 'Password Protected' )
  end
  
  # ------------------------------------------------------------------
  private

  # Set the current frame based on criteria in determine_domain, 
  # or raise a routing error if no frame is found.
  def set_frame
    @current_frame = Frame.find_by_domain( determine_domain )
    @current_frame or raise ActionController::RoutingError, "Could not find a frame matching domain: #{ determine_domain }."
  end
  
  # Logic to determine which domain to use to find a frame.
  def determine_domain
    ENV[ "FORCE_FRAME" ] || request.domain
  end
  
end