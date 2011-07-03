require 'spec_helper'

describe Option do
  let( :new_option ) { Option.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_option.should be_valid
    end
    
    it "is not valid without a good" do
      new_option.good = nil
      new_option.should_not be_valid
    end
    
    it "is not valid without a name" do
      new_option.name = nil
      new_option.should_not be_valid
    end
    
    it "is not valid without a default" do
      new_option.default = nil
      new_option.should_not be_valid
    end
  end
end
