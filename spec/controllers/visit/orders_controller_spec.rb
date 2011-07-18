require 'spec_helper'

describe Visit::OrdersController do
  let( :order ) { stub_model Order }
  
  before do
    controller.stub current_order: order
    order.stub_chain( :line_items, :any? ).and_return( true )     # Skip the :order_cannot_be_empty before_filter.
    Frame.generate  domain: 'test.host'
  end
   
  describe "PUT :update" do
    let( :params )           { { order: { shipping_address:  { first_name: 'Ship' },
                                          billing_address:   { first_name: 'Bill' }, 
                                          email:             'pa@ram.s' } } }
                                 
    let( :shipping_address ) { mock_model 'Address' }
    let( :billing_address )  { mock_model 'Address' }
    
    before do
      controller.stub params: params
      order.stub( :shipping_address= )
      order.stub( :billing_address= )
    end
    
    it "retrieves the order from the session" do
      put :update
      controller.order.should == order
    end
    
    it "sets the order's shipping address" do
      Address.stub( :new ).and_return( shipping_address )
      order.should_receive( :shipping_address= ).with( shipping_address )
      put :update
    end
    
    it "sets the order's billing address" do
      Address.stub( :new ).and_return( billing_address )
      order.should_receive( :billing_address= ).with( billing_address )
      put :update
    end
    
    it "updates the order's attributes" do
      order.should_receive( :update_attributes ).with( params[ :order ] )
      put :update
    end
    
    context "if the shipping_is_billing parameter is present" do
      before { params.merge! shipping_is_billing: '1' }
      
      it "sets the billing address attributes to the shipping address attributes" do
        Address.should_receive( :new )
               .with( { first_name: "Ship", frame_id: Frame.last.id } )
               .twice
        
        put :update
      end
    end

    context "if the order updates successfully and the addresses are both valid" do
      before do
        order.stub update_attributes: true
      end
      
      it "checks out the order" do
        order.should_receive( :checkout! )
        put :update
      end
      
      context "and the order checks out successfully" do
        before { order.stub checkout!: true }
        
        it "redirects to the PayPal form page" do
          put :update
          response.should redirect_to paypal_path
        end
      end
      
      context "and the order does not check out successfully" do
        before { order.stub checkout!: false }
        
        it "renders the edit template" do
          put :update
          response.should render_template :edit
        end
      end
    end
    
    context "if the order does not update successfully" do 
      before { order.stub update_attributes: false }
           
      it "renders the :edit template" do
        put :update
        response.should render_template :edit
      end
    end
  end

  describe "GET /paypal" do
    it "redirects to the new order path if the current order is not pending" do
      order.stub pending?: false
      
      get 'paypal'
      response.should redirect_to new_order_path
    end
  end
end