module FramesHelper
  def current_frame
    @current_frame ||= set_frame
  end
  
  private
    def set_frame
      frame = Frame.find_by_domain( determine_domain )
      frame or raise ActionController::RoutingError, "Could not find a frame matching domain: #{ determine_domain }."
    end
    
    def determine_domain
      ENV[ "FORCE_FRAME" ] || request.domain
    end
end