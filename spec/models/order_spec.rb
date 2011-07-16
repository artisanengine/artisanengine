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
  
    describe "#line_total" do
      it "returns the total price of all its line items multiplied by their quantity" do
        order       = Order.generate
        line_item_1 = LineItem.generate order: order, quantity: 3
        line_item_1.update_attributes price: 100
        
        line_item_2 = LineItem.generate order: order, quantity: 2
        line_item_2.update_attributes price: 10
        
        line_item_3 = LineItem.generate order: order, price: 1
        line_item_3.update_attributes price: 1

        order.line_total.should == 321
      end
    end
        
  end

  describe "status: " do
    let( :order ) { Order.generate }
    
    it "has a default status of 'new'" do
      new_order.status.should == 'new'
    end
    
    describe "#checkout!" do
      context "validations: " do
        it "is not valid without an E-Mail" do
          order.email = nil
          order.checkout!.should be_false
        end
        
        it "is not valid without a shipping address" do
          order.shipping_address = nil
          order.checkout!.should be_false
        end
        
        it "is not valid without a billing address" do
          order.billing_address = nil
          order.checkout!.should be_false
        end
      end
      
      context "if valid: " do
        before do
          order.email            = 'patron@example.com'
          order.subscribed       = true
          order.billing_address  = Address.generate
          order.shipping_address = Address.generate
        end
        
        context "if a patron exists with the order's E-Mail" do
          before do
            @existing_patron = Patron.generate email: 'patron@example.com'
          end
          
          it "sets the patron to the existing patron" do
            expect { order.checkout! }.not_to change( Patron, :count )
            order.patron.should == @existing_patron
          end
        end
        
        context "if a patron does not exist with the order's E-Mail" do
          it "creates a new patron with the billing address's first and last name and order's subscription status" do
            expect { order.checkout! }.to change( Patron, :count ).by( 1 )
            
            order.patron.email.should      == 'patron@example.com'
            order.patron.first_name.should == order.billing_address.first_name
            order.patron.last_name.should  == order.billing_address.last_name
            order.patron.subscribed.should == true
          end
        end
                                       
        it "checks out the order (status: pending)" do
          order.checkout!.should be_true
          order.should be_pending
        end
      end
    end
  end
end
