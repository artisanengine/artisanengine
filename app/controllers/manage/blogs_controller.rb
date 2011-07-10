module Manage
  class BlogsController < Manage::ManageController
    respond_to :html
    
    expose( :blog ) { current_frame.blog }
  end
end