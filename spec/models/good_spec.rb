require 'spec_helper'

describe Good do
  let( :new_good ) { Good.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_good.should be_valid
    end
    
    it "is not valid without a name" do
      new_good.name = nil
      new_good.should_not be_valid
    end
    
    it "is not valid without a frame" do
      new_good.frame = nil
      new_good.should_not be_valid
    end
  end
end
