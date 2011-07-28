# ------------------------------------------------------------------
# Paths

def new_image_page
  '/manage/images/new'
end

def images_page
  '/manage/images'
end

def edit_image_page_for( image )
  "/manage/images/#{ image.id }/edit"
end