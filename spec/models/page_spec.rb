require 'spec_helper'

describe Page do
  let( :new_page ) { Page.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_page.should be_valid
    end
    
    it "is not valid without a title" do
      new_page.title = nil
      new_page.should_not be_valid
    end
    
    it "is not valid without content" do
      new_page.content = nil
      new_page.should_not be_valid
    end
    
    it "is not valid without a frame" do
      new_page.frame = nil
      new_page.should_not be_valid
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
