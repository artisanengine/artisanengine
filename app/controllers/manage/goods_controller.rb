module Manage
  class GoodsController < Manage::ManageController
    respond_to :html
    
    expose( :goods )                { current_frame.goods }
    expose( :good )
    expose( :good_options )         { good.options.in_order }
    expose( :new_option )           { good_options.new }
    expose( :good_variants )        { good.variants.order( "position ASC" ) }
    expose( :new_variant )          { good_variants.new }
    expose( :good_image_attachers ) { good.image_attachers.in_order }
    expose( :new_image )            { good.images.build frame: current_frame }
   
    def create
      good.save ?
        flash[ :notice ] = "Good: #{ good.name } was successfully created." :
        flash[ :alert ]  = t( :form_alert )
      
      respond_with :manage, good
    end
    
    def update
      good.update_attributes( params[ :good ] ) ?
        flash[ :notice ] = "Good: #{ good.name } was successfully updated." :
        flash[ :alert ] = t( :form_alert )
      
      respond_with :manage, good, location: manage_good_path( good )
    end
    
    def destroy
      good.destroy ?
        redirect_to( manage_goods_path, notice: "Good: #{ good.name } was successfully destroyed." ) :
        redirect_to( manage_goods_path, notice: "Good: #{ good.name } could not be destroyed." )
    end
  end
end