class FramesController < ApplicationController
  respond_to :html
  
  expose( :frame )

  def create
    frame.save ? 
      flash[ :notice ] = "Frame: #{ frame.name } was successfully created." :
      flash[ :alert ]  = t( :form_alert )
    
    respond_with( frame )
  end
end