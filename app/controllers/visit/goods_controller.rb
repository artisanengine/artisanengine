module Visit
  class GoodsController < Visit::VisitController
    def show
      @good = current_frame.goods.find( params[ :id ] )
    end
  end
end