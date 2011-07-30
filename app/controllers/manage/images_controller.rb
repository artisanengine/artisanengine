module Manage
  class ImagesController < Manage::ManageController
    respond_to :html, :js
    
    expose( :images ) { current_frame.images.page( params[ :page ] ).per( 8 ) }
    expose( :image )
    expose( :parent ) do
      current_frame.goods.find( params[ :good_id ] ) if params[ :good_id ]
    end
    
    def create
      flash[ :notice ] = "Image: #{ image.name_or_filename } was successfully created." if image.save
      
      if parent
        ImageAttacher.create! image: image, imageable: parent
        redirect_to polymorphic_path( [ :manage, parent ], action: :edit ) and return
      end
      
      respond_with :manage, image, location: manage_images_path
    end
    
    def update
      flash[ :notice ] = "Image: #{ image.name_or_filename } was successfully updated." if image.update_attributes( params[ :image ] )
      puts image.errors.full_messages
      respond_with :manage, image, location: edit_manage_image_path( image )
    end
    
    def destroy
      flash[ :notice ] = "Image: #{ image.name_or_filename } was successfully destroyed." if image.destroy
      respond_with :manage, image
    end
    
    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    def crop
      ratio = image.image.width / image.image.thumb( '650x' ).width
      
      if params[ :priority ] == "primary"
        image.crop_priority = 'primary'
      end
      
      if params[ :priority ] == "secondary"
        image.crop_priority = 'secondary'
      end
    end
  end
end