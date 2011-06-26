class PagesController < ApplicationController
  respond_to :html
  load_and_authorize_resource :through => :current_frame
  
  def create
    @page.save ?
      flash[ :notice ] = "Page: #{ @page.title } was successfully created." :
      flash[ :alert ]  = t( :form_alert )
      
    respond_with @page
  end

end