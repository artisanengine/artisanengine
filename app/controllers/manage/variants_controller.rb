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
    
    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    # POST /manage/goods/:id/variants/sort
    def sort
      variants = current_frame.goods.find( params[ :good_id ] ).variants
      
      params[ :variant ].each_with_index do |id, index|
        variants.update_all( [ "position = ?", index + 1 ], [ 'id = ?', id ] )
      end
      
      render nothing: true
    end
  end
end