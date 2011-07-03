# ------------------------------------------------------------------
# Paths

def new_good_page
  '/manage/goods/new'
end

def edit_good_page_for( name )
  good = Good.find_by_name( name )
  "/manage/goods/#{ good.id }/edit"
end

def manage_good_page_for( name )
  good = Good.find_by_name( name )
  "/manage/goods/#{ good.id }"
end

def manage_goods_page
  "/manage/goods"
end