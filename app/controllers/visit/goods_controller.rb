module Visit
  class GoodsController < Visit::VisitController
    layout :goods_or_visit
    
    def show
      @good = current_frame.goods.find( params[ :id ] )
      @options = @good.options.to_json
    end
    
    private
    
    def goods_or_visit
      template_exists?( "layouts/goods" ) ? 'goods' : 'visit'
    end
  end
end