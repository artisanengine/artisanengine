module Manage
  class ImagesController < Manage::ManageController
    respond_to :html
    
    def index
      @images = current_frame.images
    end
    
    def new
      @image = current_frame.images.new
    end
    
    def create
      @image = current_frame.images.new( params[ :image ] )
      
      @image.save ?
        flash[ :notice ] = "Image: #{ @image.image_name } was successfully created." :
        flash[ :alert ]  = t( :form_alert )

      respond_with :manage, @image, location: manage_images_path
    end
    
    def destroy
      @image = current_frame.images.find( params[ :id ] )
      
      @image.destroy ?
        flash[ :notice ] = "Image: #{ @image.image_name } was successfully destroyed." :
        flash[ :alert ]  = "Image could not be destroyed."
      
      respond_with :manage, @image
    end
  end
end