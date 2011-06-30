module Manage
  class ManageController < ApplicationController
    before_filter :authenticate_artisan!    # Authenticate all actions.
    layout        :none_for_ajax_requests   # Don't use layouts for AJAX requests.
    
    include FramesHelper                    # Helpers for managing the current frame.
    
    private
    
    # Render template only (no layout) for AJAX requests, otherwise JavaScripts get
    # loaded twice and you spend two hours trying to figure out why a Colorbox won't close.
    def none_for_ajax_requests
      request.xhr? ? false : 'manage'
    end
  end
end