require 'spec_helper'

describe OrderAdjustment do
  let( :new_adjustment ) { OrderAdjustment.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_adjustment.should be_valid
    end
    
    it "is not valid without an order" do
      new_adjustment.order = nil
      new_adjustment.should_not be_valid
    end
    
    it "is not valid without a message" do
      new_adjustment.message = nil
      new_adjustment.should_not be_valid
    end
  end
end