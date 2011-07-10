module Manage
  class VariantsController < Manage::ManageController
    expose( :goods )        { current_frame.goods }
    expose( :good )
    expose( :good_options ) { good.options.in_order }
    expose( :variants )     { good.variants }
    expose( :variant )
    
    def create
      variant.save ?
        redirect_to( edit_manage_good_path( good ), notice: "Variant was successfully created." ) :
        redirect_to( edit_manage_good_path( good ), alert: "#{ variant.errors.full_messages }" )
    end
    
    def update
      if variant.update_attributes( params[ :variant ] )
        redirect_to edit_manage_good_path( good ), notice: "Variant was successfully updated."
      else
        flash[ :alert ] = t( :form_alert ) 
        render :edit
      end
    end
    
    def destroy
      variant.destroy ?
        redirect_to( edit_manage_good_path( good ), notice: "Variant was successfully destroyed." ) :
        redirect_to( edit_manage_good_path( good ), alert: "#{ variant.errors.full_messages }" )
    end
  end
end