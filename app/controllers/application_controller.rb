class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepend_current_frame_theme_to_view_paths
  
  # ------------------------------------------------------------------
  # Application-Wide Rescues
  
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  
  # ------------------------------------------------------------------
  # Application-Wide Helpers
  
  include ArtisanEngine::Authorization  # Helpers for authorizing resources.
  include FramesHelper                  # Helpers for managing the current frame.
  
  # ------------------------------------------------------------------
  # Application-Wide Controller Methods
  
  # Render the static 404: Not Found page.
  def render_404
    render 'public/404.html', layout: false, status: 404
  end
  
  def prepend_current_frame_theme_to_view_paths
    self.prepend_view_path "#{ Rails.root }/app/themes/#{ current_frame.domain }"
  end
end
