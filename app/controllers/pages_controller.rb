class PagesController < ApplicationController
  respond_to :html
  
  expose( :pages ) { current_frame.pages }
  expose( :page )

  def create
    page.save ? 
      flash[ :notice ] = "Page: #{ page.title } was successfully created." :
      flash[ :alert ]  = t( :form_alert )

    respond_with( page )
  end
end