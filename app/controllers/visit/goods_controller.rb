module Visit
  class GoodsController < Visit::VisitController
    layout :goods_or_visit
    
    before_filter :ensure_best_url, only: :show
    
    expose( :goods )         { current_frame.goods }
    expose( :good )
    expose( :good_variants ) { good.variants.rank( :display_order ) }
    expose( :good_images )   { good.images_in_display_order.all }
    expose( :options )       { good.options.to_json }
    expose( :new_line_item ) { LineItem.new }
        
    # ------------------------------------------------------------------
    private
    
    def goods_or_visit
      template_exists?( "layouts/goods" ) ? 'goods' : 'visit'
    end
    
    # Ensure page is accessed from the best Friendly ID.
    def ensure_best_url
      redirect_to good, status: 301 unless good.friendly_id_status.best?
    end
  end
end