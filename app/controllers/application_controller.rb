class ApplicationController < ActionController::Base
  protect_from_forgery

  # ------------------------------------------------------------------
  # Application-Wide Rescues
  
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  # ------------------------------------------------------------------
  # Application-Wide Controller Methods
  
  # Render the static 404: Not Found page.
  def render_404
    render 'public/404.html', layout: false, status: 404
  end
  
end
