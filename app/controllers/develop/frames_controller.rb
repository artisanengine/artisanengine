module Develop
  class FramesController < Develop::DevelopController
    respond_to :html
    
    expose( :frames ) { Frame.all }
    expose( :frame )
  
    def create
      frame.save ?
        flash[ :notice ] = "Frame: #{ frame.name } was successfully created." :
        flash[ :alert ]  = t( :form_alert )
    
      respond_with :develop, frame, location: develop_frames_path
    end
  end
end