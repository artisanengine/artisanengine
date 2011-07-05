module Manage
  class BlogsController < Manage::ManageController
    def show
      @blog        = current_frame.blog
    end
  end
end