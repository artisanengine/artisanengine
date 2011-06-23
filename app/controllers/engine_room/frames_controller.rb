module EngineRoom
  class FramesController < EngineRoom::EngineRoomController
    respond_to :html
    expose     :frame
    
    def new
    end
    
    def create
      frame.save ? 
        flash[ :notice ] = "Frame: #{ frame.name } was successfully created." :
        flash[ :alert ]  = t( :form_alert )
      
      respond_with frame
    end
  end
end