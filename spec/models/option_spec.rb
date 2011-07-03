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
    
    it "is not valid without a default value" do
      new_option.default_value = nil
      new_option.should_not be_valid
    end
  end
  
  context "callbacks: " do
    describe "before creating: " do
      it "sets its position to 1 if it is the only option in the good" do
        new_option.save
        new_option.position.should be 1
      end
    end
    
    describe "after creating: " do
      it "initializes its good's variants' option values" do
        new_option.default_value = "Red"
        new_option.save
        new_option.good.variants.first.option_value_1.should == "Red"
      end
    end
  end
end
