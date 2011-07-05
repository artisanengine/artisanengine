module Visit
  class BlogsController < Visit::VisitController
    def show
      @blog = current_frame.blog
    end
  end
end