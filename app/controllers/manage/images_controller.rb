module Manage
  class ImagesController < Manage::ManageController
    respond_to :html
    
    expose( :images ) { current_frame.images }
    expose( :image )
    expose( :parent ) do
      current_frame.goods.find( params[ :good_id ] ) if params[ :good_id ]
    end
    
    def create
      if image.save
        flash[ :notice ] = "Image: #{ image.image_name } was successfully created."
        
        if parent
          ImageAttacher.create! image: image, imageable: parent
          redirect_to polymorphic_path( [ :manage, parent ], action: :edit ) and return 
        end
      
      else
        flash[ :alert ] = t( :form_alert )
      end

      respond_with :manage, image, location: manage_images_path
    end
    
    def destroy
      image.destroy ?
        flash[ :notice ] = "Image: #{ image.image_name } was successfully destroyed." :
        flash[ :alert ]  = "Image could not be destroyed."
      
      respond_with :manage, image
    end
  end
end