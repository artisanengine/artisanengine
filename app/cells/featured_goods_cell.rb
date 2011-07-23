class FeaturedGoodsCell < Cell::Rails
  helper  :images
  helper  :frames
  
  include FramesHelper
  include ArtisanEngine::Theming

  def display( state )
    frame = state[ :frame ]
    limit = state[ :limit ] || 1
    
    @goods = frame.featured_case.goods_in_display_order.limit( limit )
    render
  end

end
