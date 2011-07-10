module Manage
  class PagesController < Manage::ManageController
    respond_to :html
    
    expose( :pages ) { current_frame.pages }
    expose( :page )
    
    def create
      page.save ?
        flash[ :notice ] = "Page: #{ page.title } was successfully created." :
        flash[ :alert ]  = t( :form_alert )

      respond_with :manage, page, location: manage_pages_path
    end
    
    def update
      page.update_attributes( params[ :page ] ) ?
        flash[ :notice ] = "Page: #{ page.title } was successfully updated." :
        flash[ :alert ]  = t( :form_alert )
      
      respond_with :manage, page, location: manage_pages_path
    end
    
    # ------------------------------------------------------------------
    # Non-RESTful Actions
    
    # POST /manage/page/preview
    def preview
      textile_content = params[ :textile_content ]  # Receive the Textile-formatted content via JSON.
      
      # Convert the content to Textile.
      converted_content = ArtisanEngine::Textiling.textile( textile_content )  
      
      render json: { content: converted_content }   # Render a JSON object with the converted content.
    end
  end
end