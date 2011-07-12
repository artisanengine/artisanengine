module Develop
  class ArtisansController < Develop::DevelopController
    respond_to :html
    
    expose( :artisans ) { Artisan.all }
    expose( :artisan )
        
    def create
      flash[ :notice ] = "Artisan: #{ artisan.email } was successfully created." if artisan.save
      respond_with :develop, artisan, location: develop_artisans_path
    end
  end
end