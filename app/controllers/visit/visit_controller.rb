module Visit
  class VisitController < ApplicationController
    layout 'visit'
    
    include ArtisanEngine::Theming  # Filters and methods for theming.
    include FramesHelper            # Helpers for managing the current frame.
    include OrdersHelper            # Helpers for managing the current order.
    
    before_filter :authenticate_artisan!, if: :current_frame_is_protected
    
    # ------------------------------------------------------------------
    private
    
    def current_frame_is_protected
      current_frame.protected?
    end
  end
end