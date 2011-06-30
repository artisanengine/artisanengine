module Develop
  class FramesController < Develop::DevelopController
    respond_to :html
  
    def index
      @frames = Frame.all
    end
  
    def new
      @frame = Frame.new
    end

    def create
      @frame = Frame.new( params[ :frame ] )
    
      @frame.save ?
        flash[ :notice ] = "Frame: #{ @frame.name } was successfully created." :
        flash[ :alert ]  = t( :form_alert )
    
      respond_with @frame, location: develop_frames_path
    end
  end
end