module Manage
  class PostsController < Manage::ManageController
    respond_to :html
    
    expose( :blog )  { current_frame.blog }
    expose( :posts ) { blog.posts }
    expose( :post )

    def create
      post.save ?
        flash[ :notice ] = "Post: #{ post.title } was successfully created." :
        flash[ :alert ]  = t( :form_alert )
      
      respond_with :manage, :blog, post, location: manage_blog_path
    end

    def update
      post.update_attributes( params[ :post ] ) ?
        flash[ :notice ] = "Post: #{ post.title } was successfully updated." :
        flash[ :alert ]  = t( :form_alert )
      
      respond_with :manage, :blog, post, location: manage_blog_path
    end
  end
end