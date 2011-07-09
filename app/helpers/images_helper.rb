module ImagesHelper
  def display_image( image, size = '200x200#' )
    unless image.nil?
      image_tag( image.image.thumb( size ).url )
    else
      placeholder_image( size )
    end
  end
  
  def placeholder_image( size = '200x200#', options = {} )
    width  = size.split( 'x' )[0]
    height = size.split( 'x' )[1].gsub( '#', '' )
    
    options[ :alt ]   ||= 'Placeholder Image'
    options[ :title ] ||= 'Placeholder Image'
    options[ :style ] ||= "width: #{ width }px; height: #{ height }px;"
    
    image_tag 'placeholder.jpg', options
  end
end