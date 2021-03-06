module ArtisanEngine
  # Organizing module to hold all theming functionality.
  module Theming
    extend ActiveSupport::Concern
  
    included do
      before_filter :prepend_current_frame_theme_to_view_paths
    end
  
    # ------------------------------------------------------------------
    private

    # If current frame's domain is hausleather.com, looks for views in
    # app/views/themes/hausleather and cell views in
    # app/views/themes/hausleather/cells.
    def prepend_current_frame_theme_to_view_paths
      theme_folder = current_frame.domain.split( '.' ).first
      
      self.prepend_view_path "#{ Rails.root }/app/themes/#{ theme_folder }/cells"
      self.prepend_view_path "#{ Rails.root }/app/themes/#{ theme_folder }"
    end
  end
end