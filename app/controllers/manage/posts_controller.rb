module Manage
  class PostsController < Manage::ManageController
    respond_to :html
    
    def new
      @blog = current_frame.blog
      @post = @blog.posts.new
    end
    
    def create
      @blog = current_frame.blog
      @post = @blog.posts.new( params[ :post ] )
      
      @post.save ?
        flash[ :notice ] = "Post: #{ @post.title } was successfully created." :
        flash[ :alert ]  = t( :form_alert )
      
      respond_with :manage, :blog, @post, location: manage_blog_path
    end
  end
end