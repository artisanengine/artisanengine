module Develop
  class SettingsController < Develop::DevelopController
    respond_to :html
    
    expose( :frame )
    expose( :settings ) { frame.settings }
    expose( :setting )
    
    def create
      flash[ :notice ] = "Setting saved successfully." if setting.save
      respond_with setting, location: develop_frame_settings_path( frame )
    end
  end
end