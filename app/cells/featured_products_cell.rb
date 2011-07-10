class FeaturedProductsCell < Cell::Rails
  include FramesHelper
  helper  :images
  include ArtisanEngine::Theming

  def display( state )
    frame = state[ :frame ]
    limit = state[ :limit ] || 1
    
    @goods = frame.display_cases.find_by_name( 'Featured' ).goods.limit( limit )
    render
  end

end
