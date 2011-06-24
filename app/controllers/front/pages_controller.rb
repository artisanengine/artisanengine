module Front
  class PagesController < Front::FrontController
    respond_to    :html
    before_filter :can_show_page?
    expose        :page
    
    private
      # Only show the page if it is in the current frame.
      def can_show_page?
        render_404 unless page.frame == current_frame
      end
  end
end