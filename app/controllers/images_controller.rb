class ImagesController < ApplicationController
  respond_to :html
  load_and_authorize_resource :through => :current_frame
    
  def create
    @image.save ?
      flash[ :notice ] = "Image: #{ @image.image_name } was successfully created." :
      flash[ :alert ]  = t( :form_alert )
    
    respond_with @image
  end
      
end