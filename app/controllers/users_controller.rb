class UsersController < InheritedResources::Base
  skip_authorization_check
  
  def create
    @user            = current_frame.users.new
    @user.accessible = :all if can? :manage, User
    @user.attributes = params[ :user ]
 
    create! do |success, failure|
      success.html { redirect_to users_path, notice: "User was successfully created." }
      failure.html { flash[ :alert ] = t( :form_alert ) and render :new }
    end
  end
  
  protected
    # Scope all users to the current frame by default.
    def begin_of_association_chain
      current_frame
    end
end