require 'spec_helper'

describe LineItem do
  let( :new_line_item ) { LineItem.spawn }
  
  describe "validations: " do
    it "is valid with valid attributes" do
      new_line_item.should be_valid
    end
    
    it "is not valid without a variant" do
      new_line_item.variant = nil
      new_line_item.should_not be_valid
    end
    
    it "is not valid without an order" do
      new_line_item.order = nil
      new_line_item.should_not be_valid
    end
  end
  
  context "callbacks: " do
    describe "before creating: " do
      it "captures its variant's price" do
        new_line_item.save
        new_line_item.price.should == new_line_item.variant.price
      end
    end
    
    describe "after saving: " do
      it "destroys itself if its quantity is 0" do
        new_line_item.save
        new_line_item.quantity = 0
        expect { new_line_item.save }.to change( LineItem, :count ).by( -1 )
      end
    end
  end
end
