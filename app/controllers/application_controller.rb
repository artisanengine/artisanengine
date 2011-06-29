class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include ArtisanEngine::Theming        # Filters and methods for theming.
  include ArtisanEngine::Authorization  # Filters and methods for authorization.
  
  # ------------------------------------------------------------------
  # Application-Wide Rescues
  
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from CanCan::AccessDenied,         :with => :render_404
  
  # ------------------------------------------------------------------
  # Application-Wide Helpers
  
  include FramesHelper                  # Helpers for managing the current frame.
  
  # ------------------------------------------------------------------
  # Application-Wide Controller Methods
  
  # Render the static 404: Not Found page.
  def render_404
    render 'public/404.html', layout: false, status: 404
  end
  
end
