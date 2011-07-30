module Visit
  class DisplayCasesController < Visit::VisitController
    layout :display_cases_or_visit
    
    before_filter :ensure_best_url, only: :show
    
    expose( :display_cases ) { current_frame.display_cases }
    expose( :display_case )
    expose( :goods )         { display_case.goods_in_display_order }
    
    # ------------------------------------------------------------------
    private
    
    def display_cases_or_visit
      template_exists?( "layouts/display_cases" ) ? 'display_cases' : 'visit'
    end
    
    # Ensure page is accessed from the best Friendly ID.
    def ensure_best_url
      redirect_to display_case, status: 301 unless display_case.friendly_id_status.best?
    end
  end
end