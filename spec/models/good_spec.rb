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
  
  context "callbacks: " do
    describe "after saving: " do
      it "creates a default variant" do
        good = Good.generate
        good.variants.count.should == 1
      end
      
      it "creates a default option" do
        good = Good.generate
        good.options.count.should == 1
        good.options.first.name.should == 'Type'
      end
    end
  end
end
