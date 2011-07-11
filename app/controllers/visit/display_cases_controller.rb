module Visit
  class DisplayCasesController < Visit::VisitController
    layout :display_cases_or_visit
    
    expose( :display_cases ) { current_frame.display_cases }
    expose( :display_case )
    
    # ------------------------------------------------------------------
    private
    
    def display_cases_or_visit
      template_exists?( "layouts/display_cases" ) ? 'display_cases' : 'visit'
    end
  end
end