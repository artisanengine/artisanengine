module Manage
  class ManageController < ApplicationController
    include FramesHelper                    # Helpers for managing the current frame.
    layout  :none_for_ajax_requests         # Don't use layouts for AJAX requests.
    
    # Must be logged in as an artisan or engineer to access ManageController
    # actions.
    before_filter :authenticate_artisan!, unless: :current_engineer
    
    def interface
    end
    
    # ------------------------------------------------------------------
    private
    
    # Render template only (no layout) for AJAX requests, otherwise JavaScripts get
    # loaded twice and you spend two hours trying to figure out why a Colorbox won't close.
    def none_for_ajax_requests
      request.xhr? ? false : 'manage'
    end
  end
end