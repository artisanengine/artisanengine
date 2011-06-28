module ArtisanEngine
  
  # Organizing module to hold all authorization functionality.
  # Included in the ApplicationController.
  module Authorization
    extend ActiveSupport::Concern
  
    included do
      check_authorization
    end
  
    private
  
    # Always pass the current frame to CanCan so it can initialize a user if it needs to.
    def current_ability
      @current_ability ||= Ability.new( current_user, current_frame )
    end
  end
end