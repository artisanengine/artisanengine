module Manage
  class GoodsController < Manage::ManageController
    respond_to :html
    
    expose( :goods )                { current_frame.goods }
    expose( :good )
    expose( :good_options )         { good.options.in_order }
    expose( :new_option )           { good_options.new }
    expose( :good_variants )        { good.variants.rank( :display_order ) }
    expose( :new_variant )          { good_variants.new }
    expose( :good_image_attachers ) { good.image_attachers.rank( :display_order ) }
    expose( :new_image )            { good.images.build frame: current_frame }
   
    def create
      flash[ :notice ] = "Good: #{ good.name } was successfully created." if good.save
      respond_with :manage, good, location: "/manage/goods/#{ good.id }/edit"
    end
    
    def update
      flash[ :notice ] = "Good: #{ good.name } was successfully updated." if good.update_attributes( params[ :good ] )
      respond_with :manage, good, location: "/manage/goods/#{ good.id }/edit"
    end
    
    def destroy
      flash[ :notice ] = "Good: #{ good.name } was successfully destroyed." if good.destroy
      respond_with :manage, good
    end
  end
end