module Manage
  class TagsController < Manage::ManageController
    respond_to :json
    
    expose( :tags ) do 
      current_frame.tags.where( "name LIKE ?", "%#{ params[ :q ] }%" )
    end
    
    def index
      respond_with tags
    end
  end
end