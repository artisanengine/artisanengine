require 'spec_helper'

describe Adjustment do
  let( :new_adjustment ) { Adjustment.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_adjustment.should be_valid
    end
    
    it "is not valid without an adjustable" do
      new_adjustment.adjustable = nil
      new_adjustment.should_not be_valid
    end
    
    it "is not valid without a message" do
      new_adjustment.message = nil
      new_adjustment.should_not be_valid
    end
    
    it "is not valid with an amount of 0" do
      new_adjustment.amount = 0
      new_adjustment.should_not be_valid
    end
  end
end