class UserSessionsController < ApplicationController
  expose( :user_session )
  
  def create
    if user_session.save
      redirect_to( root_path )
    else
      flash[ :alert ] = "Invalid E-Mail or password."
      render( :new )
    end
  end
  
  def destroy
    current_session.destroy and redirect_to root_path
  end
end