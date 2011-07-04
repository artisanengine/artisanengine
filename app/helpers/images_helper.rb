module ImagesHelper
  def display_image( image, size = '200x200#' )
    return nil unless image.image
    image_tag( image.image.thumb( size ).url )
  end
end