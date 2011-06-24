class PagesController < ApplicationController
  respond_to    :html
  expose        :page

  def new
    page.frame = current_frame
  end
  
  def create
    page.save ? 
      flash[ :notice ] = "Page: #{ page.title } was successfully created." :
      flash[ :alert ]  = t( :form_alert )

    respond_with( page )
  end
end