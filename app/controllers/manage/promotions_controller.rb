module Manage
  class PromotionsController < Manage::ManageController
    respond_to :html
    
    expose( :promotions ) { current_frame.promotions }
    expose( :promotion )
    
    def create
      flash[ :notice ] = "Promotion: #{ promotion.promotional_code } was successfully created." if promotion.save
      respond_with :manage, promotion, location: manage_promotions_path
    end
  end
end