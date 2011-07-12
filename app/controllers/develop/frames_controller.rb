module Develop
  class FramesController < Develop::DevelopController
    respond_to :html
    
    expose( :frames ) { Frame.all }
    expose( :frame )
  
    def create
      flash[ :notice ] = "Frame: #{ frame.name } was successfully created." if frame.save
      respond_with frame, location: develop_frames_path
    end
  end
end