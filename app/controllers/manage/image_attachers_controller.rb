module Manage
  class ImageAttachersController < Manage::ManageController
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
    
    def destroy
      if image_attacher.destroy
        flash[ :notice ] = "Image successfully removed."
        redirect_to polymorphic_url( [ :manage, parent ], action: :edit )
      else
        flash[ :alert ] = "Image could not be removed."
        redirect_to polymorphic_url( [ :manage, parent ], action: :edit )
      end
    end
    
    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    # POST /manage/goods/:id/image_attachers/sort
    def sort
      image_attachers = current_frame.goods.find( params[ :good_id ] ).image_attachers
      
      params[ :image_attacher ].each_with_index do |id, index|
        image_attachers.update_all( [ "position = ?", index + 1 ], [ 'id = ?', id ] )
      end
      
      render nothing: true
    end
        
  end
end