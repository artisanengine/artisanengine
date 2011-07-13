# ------------------------------------------------------------------
# Paths

def new_frame_setting_page_for( frame_title )
  frame = Frame.find_by_name( frame_title )
  "/develop/frames/#{ frame.id }/settings/new"
end