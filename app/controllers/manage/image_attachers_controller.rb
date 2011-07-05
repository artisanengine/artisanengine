module Manage
  class ImageAttachersController < Manage::ManageController    
    def new
      @images         = current_frame.images.all
      @image_attacher = ImageAttacher.new
    end
    
    def create
      @image_attacher           = ImageAttacher.new
      @image_attacher.image_id  = params[ :image_attacher ][ :image_id ]
      @image_attacher.imageable = parent
      
      if @image_attacher.save
        flash[ :notice ] = "Image successfully attached."
        redirect_to polymorphic_url( [ :manage, parent ], action: :edit )
      else
        flash[ :alert ] = "Image could not be attached."
        redirect_to polymorphic_url( [ :manage, parent ], action: :edit )
      end
    end
    
    def destroy
      @image_attacher = ImageAttacher.find( params[ :id ] )
      
      if @image_attacher.destroy
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
    end
    
    private
    
    def parent
      current_frame.goods.find( params[ :good_id ] ) if params[ :good_id ]
    end
    helper_method :parent
    
  end
end