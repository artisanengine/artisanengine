module Visit
  class VisitController < ApplicationController
    layout 'visit'
    
    include ArtisanEngine::Theming  # Filters and methods for theming.
    include FramesHelper            # Helpers for managing the current frame.
    include OrdersHelper            # Helpers for managing the current order.
    
    before_filter :authenticate_artisan!, if: :need_to_authenticate?
    
    private
    
    def need_to_authenticate?
      return false if engineer_signed_in?
      password_protected_frame?
    end
  end
end