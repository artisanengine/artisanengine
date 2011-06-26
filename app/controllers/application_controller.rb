class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization
  
  # ------------------------------------------------------------------
  # Application-Wide Rescues
  
  rescue_from ActiveRecord::RecordNotFound,      :with => :render_404
  
  # ------------------------------------------------------------------
  # Application-Wide Helpers
  
  include FramesHelper              # Helpers for managing the current frame.
  include InheritedResources::DSL   # Include the InheritedResources DSL in children.
  
  # ------------------------------------------------------------------
  # Application-Wide Controller Methods
  
  # Render the static 404: Not Found page.
  def render_404
    render 'public/404.html', status: 404
  end
  
  private
    # Always pass the current frame to CanCan so it can initialize a user if it needs to.
    def current_ability
      @current_ability ||= Ability.new( current_user, current_frame )
    end
end
