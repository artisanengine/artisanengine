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
  
  context "scopes: " do
    describe "::fulfilled" do
      it "returns line items with fulfillments" do
        line_item_1 = LineItem.generate
        line_item_2 = LineItem.generate
        line_item_3 = LineItem.generate
        
        Fulfillment.generate( line_item_ids: [ line_item_2.id ] )

        LineItem.fulfilled.should == [ line_item_2 ]
      end
    end
    
    describe "::unfulfilled" do
      it "returns line items without fulfillments" do
        line_item_1 = LineItem.generate
        line_item_2 = LineItem.generate
        line_item_3 = LineItem.generate
        
        Fulfillment.generate( line_item_ids: [ line_item_1.id, line_item_3.id ] )
        
        LineItem.unfulfilled.should == [ line_item_2 ]
      end
    end
      
  end
end
