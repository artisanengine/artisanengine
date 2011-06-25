class UsersController < ApplicationController
  respond_to :html
  
  expose( :user )
  
  def create
    user.save ?
      flash[ :notice ] = "User: #{ user.email } (#{ user.role }) was successfully created." :
      flash[ :alert ]  = t( :form_alert )
  
    respond_with( user )
  end
end