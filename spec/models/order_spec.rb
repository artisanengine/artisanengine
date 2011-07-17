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
 
  context "scopes: " do
    describe "::except_new" do
      it "returns orders with any status except 'new'" do
        2.times { Factory :order }
        2.times { Factory :pending_order }
        2.times { Factory :purchased_order }
        
        Order.except_new.count.should == 4
      end
    end
  end
  
  context "methods: " do
    describe "#fulfillment_status" do
      context "if all the order's line items have fulfillments" do
        it "returns 'Fulfilled'" do
          order = Factory :pending_order
          Fulfillment.generate order: order, line_item_ids: order.line_item_ids
          
          order.fulfillment_status.should == "Fulfilled"
        end
      end
      
      context "if some of the order's line items have fulfillments" do
        it "returns 'Partially Fulfilled'" do
          order = Factory :pending_order
          Fulfillment.generate order: order, line_item_ids: order.line_item_ids.drop( 1 )
          
          order.fulfillment_status.should == "Partially Fulfilled"
        end
      end
          
      context "if none of the order's line items have fulfillments" do
        it "returns 'Not Fulfilled'" do
          order = Factory :pending_order
          
          order.fulfillment_status.should == "Not Fulfilled"
        end
      end
    end
    
    describe "#set_id_in_frame" do
      context "if it is the only order in the frame" do
        it "initializes to 1001" do
          new_order.set_id_in_frame!
          new_order.id_in_frame.should == 1001
        end
      end
      
      context "if it is not the only order in the frame" do
        it "initializes to one higher than the last order's id_in_frame" do
          frame  = Frame.generate
          
          order1 = Order.generate frame: frame
          order2 = Order.generate frame: frame
          order3 = Order.generate frame: frame
          
          for order in [ order1, order2, order3 ]
            order.set_id_in_frame!
          end

          order1.id_in_frame.should == 1001
          order2.id_in_frame.should == 1002
          order3.id_in_frame.should == 1003
        end
        
        it "is not affected by orders in other frames" do
          frame1 = Frame.generate
          frame2 = Frame.generate
          
          order1 = Order.generate frame: frame1
          order2 = Order.generate frame: frame2
          order3 = Order.generate frame: frame1
          
          for order in [ order1, order2, order3 ]
            order.set_id_in_frame!
          end
          
          order2.id_in_frame.should == 1001
          order3.id_in_frame.should == 1002
        end
      end
    end
    
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
        
    describe "#total" do
      it "returns the line total plus any applicable adjustments" do
        order       = Order.generate
        line_item_1 = LineItem.generate order: order, quantity: 3
        line_item_1.update_attributes price: 100
        
        order.total.should == 300
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
        
        it "sets the order's frame-specific ID" do
          order.checkout!
          order.id_in_frame.should == 1001
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
        
        it "associates its addresses with its patron" do
          order.checkout!
          order.patron.addresses.count.should == 2
        end
                                       
        it "sets the order's status to Pending" do
          order.checkout!.should be_true
          order.should be_pending
        end
      end
    end
        
    describe "#purchase!" do
      let( :order ) { Factory :pending_order }
      
      it "sets the order's status to Purchased" do
        order.purchase!
        order.should be_purchased
      end
    end
    
    describe "#fail!" do
      let( :order ) { Factory :pending_order }
      
      it "sets the order's status to Failed" do
        order.fail!
        order.should be_failed
      end
    end
  end

  describe "when setting a shipping address" do
    let( :order ) { Order.generate }
    
    context "if an address with the same attributes already exists" do
      before do
        @address_attributes = Factory.attributes_for :address
        @existing_address   = Address.create! @address_attributes
      end
      
      it "sets the order's address to the existing address" do
        expect { 
          order.shipping_address = Address.new @address_attributes
        }.not_to change( Address, :count )
        
        order.shipping_address.should == @existing_address
      end
    end
    
    context "if an address with the same attributes does not already exist" do
      let( :new_address ) { Factory.build :address }
      
      it "creates and sets the order's address to the new address" do
        expect { 
          order.shipping_address = new_address 
        }.to change( Address, :count ).by( 1 )
        
        order.shipping_address.should == new_address
      end
    end
  end
  
  describe "when setting a billing address" do
    let( :order ) { Order.generate }
    
    context "if an address with the same attributes already exists" do
      before do
        @address_attributes = Factory.attributes_for :address
        @existing_address   = Address.create! @address_attributes
      end
      
      it "sets the order's address to the existing address" do
        expect { 
          order.billing_address = Address.new @address_attributes
        }.not_to change( Address, :count )
        
        order.billing_address.should == @existing_address
      end
    end
    
    context "if an address with the same attributes does not already exist" do
      let( :new_address ) { Factory.build :address }
      
      it "creates and sets the order's address to the new address" do
        expect { 
          order.billing_address = new_address 
        }.to change( Address, :count ).by( 1 )
        
        order.billing_address.should == new_address
      end
    end
  end
end
