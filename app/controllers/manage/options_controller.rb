module Manage
  class OptionsController < Manage::ManageController
    def create
      @good = current_frame.goods.find( params[ :good_id ] )
      
      @option = @good.options.new( params[ :option ] )
      
      @option.save ? 
        redirect_to( manage_good_path( @good ), notice: "Option was successfully added." ) :
        redirect_to( manage_good_path( @good ), alert: "Option could not be added." )
    end
  end
end