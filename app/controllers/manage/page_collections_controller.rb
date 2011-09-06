module Manage
  class PageCollectionsController < Manage::ManageController
    respond_to :html
    
    expose( :page_collections ) { current_frame.page_collections }
    expose( :page_collection )
    #expose( :new_collect )   { Collect.new }

    def create
      flash[ :notice ] = "Page Collection: #{ page_collection.name } was successfully created." if page_collection.save
      respond_with :manage, page_collection, location: manage_page_collections_path
    end
    
    #def update
    #  flash[ :notice ] = "Display Case: #{ display_case.name } was successfully updated." if display_case.update_attributes( params[ :display_case ] )
    #  respond_with :manage, display_case, location: manage_display_cases_path
    #end
    
    #def destroy
    #  flash[ :notice ] = "Display Case: #{ display_case.name } was successfully destroyed." if display_case.destroy      
    #  respond_with :manage, display_case
    #end
  end
end