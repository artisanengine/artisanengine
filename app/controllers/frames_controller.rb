class FramesController < InheritedResources::Base
  
  create! do |success, failure|
    failure.html { flash[ :alert ] = t( :form_alert ) and render :new }
  end
  
end