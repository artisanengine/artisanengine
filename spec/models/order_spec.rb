require 'spec_helper'

describe Order do
  let( :new_order ) { Order.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_order.should be_valid
    end
    
    it "is not valid without a frame" do
      new_order.frame = nil
      new_order.should_not be_valid
    end
  end
end
