class PagesController < ApplicationController
  include PagesHelper
  
  respond_to :html
  respond_to :json, only: [ :preview ]
  
  load_and_authorize_resource
  
  def create
    @page.save ?
      flash[ :notice ] = "Page: #{ @page.title } was successfully created." :
      flash[ :alert ]  = t( :form_alert )
      
    respond_with @page
  end
  
  # POST /preview
  def preview
    textile_content   = params[ :textile_content ]  # Receive the Textile-formatted content via JSON.
    converted_content = textile( textile_content )  # Convert the content to Textile.
    render json: { content: converted_content }     # Render a JSON object with the converted content.
  end

end