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
      
      if @image.save
        flash[ :notice ] = "Image: #{ @image.image_name } was successfully created."
        if parent
          ImageAttacher.create! image: @image, imageable: parent
          redirect_to polymorphic_path( [ :manage, parent ], action: :edit ) and return 
        end
      else
        flash[ :alert ]  = t( :form_alert )
      end

      respond_with :manage, @image, location: manage_images_path
    end
    
    def destroy
      @image = current_frame.images.find( params[ :id ] )
      
      @image.destroy ?
        flash[ :notice ] = "Image: #{ @image.image_name } was successfully destroyed." :
        flash[ :alert ]  = "Image could not be destroyed."
      
      respond_with :manage, @image
    end
    
    private
    
    def parent
      Good.find( params[ :good_id ] ) if params[ :good_id ]
    end
  end
end