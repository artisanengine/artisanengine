require 'spec_helper'

describe Fulfillment do
  let( :new_fulfillment ) { Fulfillment.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_fulfillment.should be_valid
    end
    
    it "is not valid without an order" do
      new_fulfillment.order = nil
      new_fulfillment.should_not be_valid
    end
    
    it "is not valid without a shipping method" do
      new_fulfillment.shipping_method = nil
      new_fulfillment.should_not be_valid
    end
    
    it "is not valid without at least one line item" do
      new_fulfillment.line_item_ids = nil
      new_fulfillment.should_not be_valid
    end
  end
end