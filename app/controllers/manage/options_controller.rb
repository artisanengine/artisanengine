module Manage
  class OptionsController < Manage::ManageController
    def create
      @good   = current_frame.goods.find( params[ :good_id ] )
      @option = @good.options.new( params[ :option ] )
      
      @option.save ? 
        redirect_to( edit_manage_good_path( @good ), notice: "Option was successfully added." ) :
        redirect_to( edit_manage_good_path( @good ), alert: "Option could not be added." )
    end
    
    def edit
      @good   = current_frame.goods.find( params[ :good_id ] )
      @option = @good.options.find( params[ :id ] )
    end
    
    def update
      @good   = current_frame.goods.find( params[ :good_id ] )
      @option = @good.options.find( params[ :id ] )
      
      if @option.update_attributes( params[ :option ] )
        redirect_to edit_manage_good_path( @good ), notice: "Option was successfully updated."
      else
        flash[ :alert ] = t( :form_alert )
        render :edit
      end
    end
    
    def destroy
      @good   = current_frame.goods.find( params[ :good_id ] )
      @option = @good.options.find( params[ :id ] )
      
      @option.destroy ?
        redirect_to( edit_manage_good_path( @good ), notice: "Option was successfully removed." ) :
        redirect_to( edit_manage_good_path( @good ), alert: "Option could not be removed." )
    end
  end
end