class UsersController < InheritedResources::Base
  
  create! do |success, failure|
    success.html { redirect_to users_path, notice: "User was successfully created." }
    failure.html { flash[ :alert ] = t( :form_alert ) and render :new }
  end
  
  protected
    # Scope all users to the current frame by default.
    def begin_of_association_chain
      current_frame
    end
end