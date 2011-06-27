class ImagesController < ApplicationController
  respond_to :html
  skip_authorization_check
  load_resource
  
  def create
    @image.save ?
      flash[ :notice ] = "Image: #{ @image.image_name } was successfully created." :
      flash[ :alert ]  = t( :form_alert )
    
    respond_with @image
  end
      
end