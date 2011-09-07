module Visit
  class PageCollectionsController < Visit::VisitController
    layout :page_collections_or_visit
    
    before_filter :ensure_best_url, only: :show
    
    expose( :page_collections ) { current_frame.page_collections }
    expose( :page_collection )
    expose( :pages )         { page_collection.pages_in_display_order }
    
    # ------------------------------------------------------------------
    private
    
    def page_collections_or_visit
      template_exists?( "layouts/page_collections" ) ? 'page_collections' : 'visit'
    end
    
    # Ensure page is accessed from the best Friendly ID.
    def ensure_best_url
      redirect_to page_collection, status: 301 unless page_collection.friendly_id_status.best?
    end
  end
end