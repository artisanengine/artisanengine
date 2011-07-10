module Manage
  class CollectsController < Manage::ManageController
    expose( :display_case ) { current_frame.display_cases.find( params[ :display_case_id ] ) }
    expose( :collects )     { display_case.collects }
    expose( :collect )
    
    def create
      if collect.save
        redirect_to edit_manage_display_case_path( display_case ), notice: 'Good was successfully added.'
      else
        redirect_to edit_manage_display_case_path( display_case ), notice: 'Good could not be added.'
      end
    end
    
    def destroy
      if collect.destroy
        redirect_to edit_manage_display_case_path( display_case ), notice: 'Good was successfully removed.'
      else
        redirect_to edit_manage_display_case_path( display_case ), notice: 'Good could not be removed.'
      end
    end
  end
end