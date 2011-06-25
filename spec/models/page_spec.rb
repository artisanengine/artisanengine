require 'spec_helper'

describe Page do
  let( :new_page ) { Factory.build :page }
  
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
end
