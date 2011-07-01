require 'spec_helper'

describe Tag do
  let( :new_tag ) { Tag.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_tag.should be_valid
    end
    
    it "is not valid without a name" do
      new_tag.name = nil
      new_tag.should_not be_valid
    end
    
    it "is not valid without a frame" do
      new_tag.frame = nil
      new_tag.should_not be_valid
    end
  end
end
