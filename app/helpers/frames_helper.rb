module FramesHelper
  def current_frame
    @current_frame ||= set_frame
  end
  
  private
    def set_frame
      frame = Frame.find_by_domain( request.domain )
      frame or raise ActionController::RoutingError, "Could not find a frame matching domain: #{ request.domain }."
    end
end