module ImagesHelper
  def display_image( image, size = '200x200#', options = {} )
    unless image.nil?
      image_tag( image.image.thumb( size ).url, options )
    else
      placeholder_image( size, options )
    end
  end
  
  def url_for_image( image )
    image.nil? ? asset_path( 'placeholder.jpg' ) : image.image.remote_url
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