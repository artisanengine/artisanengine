module ImagesHelper
  def display_image( image, size = '200x200>', options = {} )
    cropping = options[ :cropping ]
    
    return placeholder_image( size, options )    if image.nil?
    return cropped_image( image, size, options ) if cropping
    
    image_tag( image.image.thumb( size ).url, options )
  end
  
  def url_for_image( image )
    return asset_path( 'placeholder.jpg' ) if image.nil?
    image.image.remote_url
  end
  
  def cropped_image( image, size = '200x200>', options = {} )
    cropping = options[ :cropping ]
    
    return placeholder_image( size, options ) unless cropping == :primary or cropping == :secondary
    
    if cropping == :primary
      image_tag image.image.process( :crop,
                                     x:      image.primary_cropping[0], 
  							                     y:      image.primary_cropping[1], 
  							                     width:  image.primary_cropping[2], 
  							                     height: image.primary_cropping[3] ).thumb( size )
  							                                                        .url
  	elsif cropping == :secondary
  	  image_tag image.image.process( :crop,
                                     x:      image.secondary_cropping[0], 
  							                     y:      image.secondary_cropping[1], 
  							                     width:  image.secondary_cropping[2], 
  							                     height: image.secondary_cropping[3] ).thumb( size )
  							                                                          .url
  	end
  end
  
  def placeholder_image( size = '200x200>', options = {} )
    width  = size.split( 'x' )[0]
    height = size.split( 'x' )[1].gsub( /[#>]/, '' )
    
    options[ :alt ]   ||= 'Placeholder Image'
    options[ :title ] ||= 'Placeholder Image'
    options[ :style ] ||= "width: #{ width }px; height: #{ height }px;"
    
    image_tag 'placeholder.jpg', options
  end
end