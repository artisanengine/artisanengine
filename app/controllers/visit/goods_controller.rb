module Visit
  class GoodsController < Visit::VisitController
    layout :goods_or_visit
    
    expose( :goods )         { current_frame.goods }
    expose( :good )
    expose( :options )       { good.options.to_json }
    expose( :new_line_item ) { LineItem.new }
        
    # ------------------------------------------------------------------
    private
    
    def goods_or_visit
      template_exists?( "layouts/goods" ) ? 'goods' : 'visit'
    end
  end
end