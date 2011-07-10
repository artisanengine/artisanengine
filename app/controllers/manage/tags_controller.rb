module Manage
  class TagsController < Manage::ManageController
    expose( :tags ) { current_frame.tags }
    
    def index
      respond_to do |format|
        format.json { render json: tags.where( "name LIKE ?", "%#{ params[ :q ] }%" ) }
      end
    end
  end
end