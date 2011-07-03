module Manage
  class VariantsController < Manage::ManageController
    def create
      @good    = current_frame.goods.find( params[ :good_id ] )
      @variant = @good.variants.new( params[ :variant ] )
      
      @variant.save ?
        redirect_to( edit_manage_good_path( @good ), notice: "Variant was successfully created." ) :
        redirect_to( edit_manage_good_path( @good ), alert: "#{ @variant.errors.full_messages }" )
    end
  end
end