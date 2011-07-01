require 'spec_helper'

describe Post do
  let( :new_post ) { Post.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_post.should be_valid
    end
    
    it "is not valid without a title" do
      new_post.title = nil
      new_post.should_not be_valid
    end
    
    it "is not valid without content" do
      new_post.content = nil
      new_post.should_not be_valid
    end
    
    it "is not valid without a blog" do
      new_post.blog = nil
      new_post.should_not be_valid
    end
  end
  
  context "callbacks: " do
    context "before saving: " do
      it "converts its content from Textile to HTML and stores it in html_content" do
        page = Page.generate content: 'A *bold* man.'
        page.html_content.should == '<p>A <strong>bold</strong> man.</p>'
      end
    end
  end
end