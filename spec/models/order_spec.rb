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
  
  context "methods: " do
    describe "#line_item_from" do
      let( :order ) { Order.generate }

      context "when given a variant ID" do
        let( :variant ) { Variant.generate }

        context "if a duplicate line item does not already exist in the order" do
          it "returns a populated new line item using the variant" do
            new_line_item = order.line_item_from( variant.id )

            new_line_item.should be_a LineItem
            new_line_item.should be_new_record

            new_line_item.order.should    == order
            new_line_item.variant.should  == variant
          end
        end

        context "if a duplicate line item exists in the order" do
          it "returns the existing line item with its quantity incremented by 1" do
            duplicate_line_item = LineItem.generate order: order, variant: variant
            
            new_line_item = order.line_item_from( variant.id )

            new_line_item.should          == duplicate_line_item
            new_line_item.quantity.should == 2
          end
        end
      end

      context "when not given a variant ID" do
        it "returns a blank line item populated with the order only" do
          blank_line_item = order.line_item_from

          blank_line_item.should be_a LineItem
          blank_line_item.should be_new_record

          blank_line_item.order.should == order
          blank_line_item.variant.should be_nil
        end
      end
    end
  end
end
