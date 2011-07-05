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
    
    it "is not valid without a blog" do
      new_post.blog = nil
      new_post.should_not be_valid
    end
  end
  
  context "callbacks: " do
    context "before saving: " do
      it "converts its content from Textile to HTML and stores it in html_content" do
        post = Post.generate content: 'A *bold* man.'
        post.html_content.should == '<p>A <strong>bold</strong> man.</p>'
      end
    end
    
    context "after saving: " do
      it "converts its tag_names to tag associations" do
        post = Post.generate tag_names: 'cat, man bear pig, dog'        
        
        post.tags.count.should   == 3
        post.tags[0].name.should == "cat"
        post.tags[1].name.should == "man bear pig"
        post.tags[2].name.should == "dog"
      end
    end
  end

  context "accessors: " do
    describe "#tag_names: " do
      it "returns a comma-separated list of tags" do
        Post.generate tag_names: "man, bear, pig"
        
        post = Post.last
        post.tag_names.should == "man, bear, pig"
      end
    end
  end
  
  context "scopes: " do
    describe "#by_year: " do
      it "returns all posts created in the given year" do
        Post.generate created_at: Date.new( 2009, 12, 31 )
        Post.generate created_at: Date.new( 2010, 1, 1 )
        Post.generate created_at: Date.new( 2010, 12, 31 )
        Post.generate created_at: Date.new( 2011, 1, 1 )
        
        Post.by_year( 2010 ).count.should == 2
      end
    end
  end
end