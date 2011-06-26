class FramesController < ApplicationController
  respond_to :html
  load_and_authorize_resource
  
  def create
    @frame.save ?
      flash[ :notice ] = "Frame: #{ @frame.name } was successfully created." :
      flash[ :alert ]  = t( :form_alert )
    
    respond_with @frame
  end
end