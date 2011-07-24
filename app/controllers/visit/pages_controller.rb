module Visit
  class PagesController < Visit::VisitController
    respond_to :html
    layout     :pages_or_visit
    
    expose( :pages ) { current_frame.pages }
    expose( :page )

    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    # GET /
    def home
    end
  
    # ------------------------------------------------------------------
    private

    def pages_or_visit
      # Use the normal layout for the home page.
      return 'visit' if request.path == root_path
      
      # Use the page-specific layout if it exists.
      template_exists?( "layouts/pages" ) ? 'pages' : 'visit'
    end
    
  end
end