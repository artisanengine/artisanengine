class PagesController < ApplicationController
  include PagesHelper
  
  respond_to :html
  respond_to :js, only: [ :preview ]
  
  load_and_authorize_resource :through => :current_frame
  
  def create
    @page.save ?
      flash[ :notice ] = "Page: #{ @page.title } was successfully created." :
      flash[ :alert ]  = t( :form_alert )
      
    respond_with @page
  end
  
  def preview
    @page_content = textile( params[ :page_content] )
  end

end