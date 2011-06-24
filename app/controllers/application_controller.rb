class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # ------------------------------------------------------------------
  # Application-Wide Helpers
  
  include FramesHelper      # Helpers for managing the current frame.
  
  # ------------------------------------------------------------------
  # Application-Wide Controller Methods
  
  # Render the static 404: Not Found page.
  def render_404
    render 'public/404.html', status: 404
  end
end
