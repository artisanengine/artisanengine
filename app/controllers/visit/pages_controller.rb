module Visit
  class PagesController < Visit::VisitController
    respond_to :html
    
    expose( :pages ) { current_frame.pages }
    expose( :page )

    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    # GET /
    def home
    end
  
  end
end