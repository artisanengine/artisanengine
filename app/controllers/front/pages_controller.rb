module Front
  class PagesController < Front::FrontController
    respond_to    :html
    before_filter :can_show_page?
    expose        :page
    
    private
      # Determine if the page is in the current frame.
      def can_show_page?
        render 'public/404.html', status: 404 if page.frame != current_frame
      end
  end
end