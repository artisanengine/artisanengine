module Manage
  class TagsController < Manage::ManageController
    def index
      @tags = current_frame.tags
      
      respond_to do |format|
        format.json { render json: @tags.where( "name LIKE ?", "%#{ params[ :q ] }%" ) }
      end
    end
  end
end