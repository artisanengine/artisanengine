module Manage
  class CollectsController < Manage::ManageController
    def create
      @display_case = current_frame.display_cases.find( params[ :display_case_id ] )
      @good         = current_frame.goods.find( params[ :good_id ] )
      @collect      = Collect.new( display_case: @display_case, good: @good )
      
      if @collect.save
        redirect_to edit_manage_display_case_path( @display_case ), notice: 'Good was successfully added.'
      else
        redirect_to edit_manage_display_case_path( @display_case ), notice: 'Good could not be added.'
      end
    end
    
    def destroy
      @collect = Collect.where( "display_case_id = ? AND good_id = ?", params[ :display_case_id ], params[ :good_id ] ).first
      
      if @collect.destroy
        redirect_to edit_manage_display_case_path( @display_case ), notice: 'Good was successfully removed.'
      else
        redirect_to edit_manage_display_case_path( @display_case ), notice: 'Good could not be removed.'
      end
    end
  end
end