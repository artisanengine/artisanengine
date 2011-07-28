module Manage
  class ImagesController < Manage::ManageController
    respond_to :html, :js
    
    expose( :images ) { current_frame.images.page( params[ :page ] ).per( 8 ) }
    expose( :image )
    expose( :parent ) do
      current_frame.goods.find( params[ :good_id ] ) if params[ :good_id ]
    end
    
    def create
      flash[ :notice ] = "Image: #{ image.image_name } was successfully created." if image.save
      
      if parent
        ImageAttacher.create! image: image, imageable: parent
        redirect_to polymorphic_path( [ :manage, parent ], action: :edit ) and return
      end
      
      respond_with :manage, image, location: manage_images_path
    end
    
    def destroy
      flash[ :notice ] = "Image: #{ image.image_name } was successfully destroyed." if image.destroy
      respond_with :manage, image
    end
    
    # Non-RESTful Actions
    def crop
    end
  end
end