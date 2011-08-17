module Visit
  class PromotionsController < Visit::VisitController
    def apply
      promotion = Promotion.valid_promotion?( current_frame, params[ :promotional_code ] )
      current_order.apply_promotion( promotion ) if promotion
      
      redirect_to new_order_path
    end
  end
end