module Visit
  class GoodsController < Visit::VisitController
    def show
      @good = current_frame.goods.find( params[ :id ] )
      @options = @good.options.to_json
    end
  end
end