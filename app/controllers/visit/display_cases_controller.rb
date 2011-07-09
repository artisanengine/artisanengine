module Visit
  class DisplayCasesController < Visit::VisitController
    layout :display_cases_or_visit
    
    def show
      @case = current_frame.display_cases.find( params[ :id ] )
    end
    
    private
    
    def display_cases_or_visit
      template_exists?( "layouts/display_cases" ) ? 'display_cases' : 'visit'
    end
  end
end