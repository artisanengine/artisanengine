class FramesController < InheritedResources::Base
  load_and_authorize_resource
  
  create! do |success, failure|
    failure.html { flash[ :alert ] = t( :form_alert ) and render :new }
  end
  
end