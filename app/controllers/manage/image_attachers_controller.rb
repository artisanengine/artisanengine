module Manage
  class ImageAttachersController < Manage::ManageController
    respond_to :html, :json
    
    expose( :images )         { current_frame.images }
    expose( :image_attacher )
    expose( :parent ) do
      current_frame.goods.find( params[ :good_id ] )
    end

    def create
      image_attacher.imageable = parent

      if image_attacher.save
        flash[ :notice ] = "Image successfully attached."
        redirect_to polymorphic_url( [ :manage, parent ], action: :edit )
      else
        flash[ :alert ] = "Image could not be attached."
        redirect_to polymorphic_url( [ :manage, parent ], action: :edit )
      end
    end
    
    def update
      image_attacher.imageable = parent
      image_attacher.update_attributes( params[ :image_attacher ] )
      respond_with image_attacher, location: polymorphic_url( [ :manage, parent ], action: :edit )
    end
    
    def destroy
      if image_attacher.destroy
        flash[ :notice ] = "Image successfully removed."
        redirect_to polymorphic_url( [ :manage, parent ], action: :edit )
      else
        flash[ :alert ] = "Image could not be removed."
        redirect_to polymorphic_url( [ :manage, parent ], action: :edit )
      end
    end        
  end
end