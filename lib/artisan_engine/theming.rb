module ArtisanEngine
  # Organizing module to hold all theming functionality.
  module Theming
    extend ActiveSupport::Concern
  
    included do
      before_filter :prepend_current_frame_theme_to_view_paths
      layout        :none_for_ajax_requests
    end
  
    private

    # If request domain is hausleather.com, looks for views in
    # app/views/themes/hausleather.com.
    def prepend_current_frame_theme_to_view_paths
      theme_folder = current_frame.domain.split( '.' ).first
      self.prepend_view_path "#{ Rails.root }/app/themes/#{ theme_folder }"
    end

    # Render template only (no layout) for AJAX requests, otherwise JavaScripts get
    # loaded twice and you spend two hours trying to figure out why a Colorbox won't close.
    def none_for_ajax_requests
      request.xhr? ? false : 'application'
    end
  end
end