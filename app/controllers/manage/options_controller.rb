module Manage
  class OptionsController < Manage::ManageController
    expose( :goods )   { current_frame.goods }
    expose( :good )
    expose( :options ) { good.options }
    expose( :option )
    
    def create
      option.save ? 
        redirect_to( edit_manage_good_path( good ), notice: "Option was successfully added." ) :
        redirect_to( edit_manage_good_path( good ), alert: "Option could not be added." )
    end
    
    def update
      if option.update_attributes( params[ :option ] )
        redirect_to edit_manage_good_path( good ), notice: "Option was successfully updated."
      else
        flash[ :alert ] = t( :form_alert )
        render :edit
      end
    end
    
    def destroy
      option.destroy ?
        redirect_to( edit_manage_good_path( good ), notice: "Option was successfully removed." ) :
        redirect_to( edit_manage_good_path( good ), alert: "Option could not be removed." )
    end
  end
end