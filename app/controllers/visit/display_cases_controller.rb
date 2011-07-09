module Visit
  class DisplayCasesController < Visit::VisitController
    def show
      @case = current_frame.display_cases.find( params[ :id ] )
    end
  end
end