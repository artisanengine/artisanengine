class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # ------------------------------------------------------------------
  # Application-Wide Rescues
  
  rescue_from ActiveRecord::RecordNotFound,
              ActionController::RoutingError, with: :render_404
  
  # ------------------------------------------------------------------
  # Application-Wide Controller Methods
  
  # Render the static 404: Not Found page.
  def render_404
    render '404', layout: false, status: 404
  end
  
end
