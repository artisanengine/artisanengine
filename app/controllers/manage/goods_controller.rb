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
      
      respond_with :manage, @good
    end
    
    def show
      @good = current_frame.goods.find( params[ :id ] )
    end
    
    def edit
      @good         = current_frame.goods.find( params[ :id ] )
      @good_options = @good.options.in_order.all
    end
    
    def update
      @good = current_frame.goods.find( params[ :id ] )
      
      if @good.update_attributes( params[ :good ] )
        flash[ :notice ] = "Good: #{ @good.name } was successfully updated."
      else
        flash[ :alert ] = t( :form_alert )
        @good_options = @good.options.in_order.all
      end
      
      respond_with :manage, @good, location: manage_good_path( @good )
    end
  end
end