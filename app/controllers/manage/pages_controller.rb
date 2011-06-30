module Manage
  class PagesController < Manage::ManageController
    respond_to :html
    
    include PagesHelper
    
    def index
      @pages = current_frame.pages
    end
    
    def new
      @page = current_frame.pages.new
    end
    
    def create
      @page = current_frame.pages.new( params[ :page ] )
      
      @page.save ?
        flash[ :notice ] = "Page: #{ @page.title } was successfully created." :
        flash[ :alert ]  = t( :form_alert )

      respond_with @page, location: manage_pages_path
    end
    
    # POST /manage/page/preview
    def preview
      textile_content   = params[ :textile_content ]  # Receive the Textile-formatted content via JSON.
      converted_content = textile( textile_content )  # Convert the content to Textile.
      render json: { content: converted_content }     # Render a JSON object with the converted content.
    end
  end
end