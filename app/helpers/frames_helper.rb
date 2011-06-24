module FramesHelper
  
  # Retrieve the cached frame or set a new one.
  def current_frame
    @current_frame ||= set_frame
  end
  
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