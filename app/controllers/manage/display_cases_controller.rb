module Manage
  class DisplayCasesController < Manage::ManageController
    respond_to :html
    
    def index
      @display_cases = current_frame.display_cases
    end
    
    def new
      @display_case = current_frame.display_cases.build
    end
    
    def create
      @display_case = current_frame.display_cases.build( params[ :display_case ] )
      
      @display_case.save ?
        flash[ :notice ] = "Display Case: #{ @display_case.name } was successfully created." :
        flash[ :alert ]  = t( :form_alert )

      respond_with :manage, @display_case, location: manage_display_cases_path
    end
  end
end