module Manage
  class GoodsController < Manage::ManageController
    respond_to :html
    
    def new
      @good = current_frame.goods.build
    end
    
    def create
      @good = current_frame.goods.build( params[ :good ] )
      
      @good.save ?
        flash[ :notice ] = "Good: #{ @good.name } was successfully created." :
        flash[ :alert ]  = t( :form_alert )
      
      respond_with( :manage, @good )
    end
    
    def show
      @good = current_frame.goods.find( params[ :id ] )
    end
  end
end