module Manage
  class DisplayCasesController < Manage::ManageController
    respond_to :html
    
    expose( :display_cases ) { current_frame.display_cases }
    expose( :display_case )

    def create
      display_case.save ?
        flash[ :notice ] = "Display Case: #{ display_case.name } was successfully created." :
        flash[ :alert ]  = t( :form_alert )

      respond_with :manage, display_case, location: manage_display_cases_path
    end
    
    def update
      display_case.update_attributes( params[ :display_case ] ) ?
        flash[ :notice ] = "Display Case: #{ display_case.name } was successfully updated." :
        flash[ :alert ]  = t( :form_alert )

      respond_with :manage, display_case, location: manage_display_cases_path
    end
    
    def destroy
      display_case.destroy ?
        flash[ :notice ] = "Display Case: #{ display_case.name } was successfully destroyed." :
        flash[ :alert ]  = "Display Case: #{ display_case.name } could not be destroyed."
      
      respond_with :manage, display_case, location: manage_display_cases_path
    end
  end
end