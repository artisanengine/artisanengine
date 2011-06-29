class UsersController < ApplicationController
  respond_to :html
  load_and_authorize_resource
  
  def create
    @user.accessible = :all if can? :manage, User
    @user.attributes = params[ :user ]
 
    @user.save ?
      flash[ :notice ] = "User: #{ @user.email } was successfully created." :
      flash[ :alert ]  = t( :form_alert )
    
    respond_with @user, location: users_path
  end
end