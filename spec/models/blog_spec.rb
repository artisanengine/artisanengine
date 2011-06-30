require 'spec_helper'

describe Blog do
  let( :new_blog ) { Blog.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_blog.should be_valid
    end
    
    it "is not valid without a name" do
      new_blog.name = nil
      new_blog.should_not be_valid
    end
    
    it "is not valid without a frame" do
      new_blog.frame = nil
      new_blog.should_not be_valid
    end
  end
end