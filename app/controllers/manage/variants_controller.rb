module Manage
  class VariantsController < Manage::ManageController
    respond_to :html, :json
    
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
      flash[ :notice ] = "Variant was successfully updated." if variant.update_attributes( params[ :variant ] ) and !request.xhr?
      respond_with variant, location: edit_manage_good_path( good )
    end  
    
    def destroy
      variant.destroy ?
        redirect_to( edit_manage_good_path( good ), notice: "Variant was successfully destroyed." ) :
        redirect_to( edit_manage_good_path( good ), alert: "#{ variant.errors.full_messages }" )
    end
  end
end