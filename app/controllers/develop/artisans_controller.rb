module Develop
  class ArtisansController < Develop::DevelopController
    respond_to :html
    
    def index
      @artisans = Artisan.all
    end
    
    def new
      @artisan = Artisan.new
    end
    
    def create
      @artisan = Artisan.new( params[ :artisan ] )
      
      @artisan.save ?
        flash[ :notice ] = "Artisan: #{ @artisan.email } was successfully created." :
        flash[ :alert ]  = t( :form_alert )

      respond_with @artisan, location: develop_artisans_path
    end
  end
end