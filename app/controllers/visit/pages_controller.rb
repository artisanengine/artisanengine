module Visit
  class PagesController < Visit::VisitController
    respond_to :html
    
    def show
      @page = current_frame.pages.find( params[ :id ] )
    end

    # GET /
    def home
    end
  
  end
end