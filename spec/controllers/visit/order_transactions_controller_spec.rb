require 'spec_helper'
include ActiveMerchant::Billing::Integrations

describe Visit::OrderTransactionsController do
  before { @frame = Frame.generate domain: 'test.host' }
  
  describe "#ipns" do
    let( :notification ) { mock 'PaypalNotification' }
    let( :order )        { stub_model Order }
    
    before do 
      controller.stub current_frame: @frame
      
      Order.stub find: order
      
      Paypal::Notification.stub new: notification
      notification.stub :acknowledge
      notification.stub :invoice
      notification.stub :complete?
      notification.stub :gross
      notification.stub :transaction_id
    end
    
    it "creates a new PayPal Notification with the request parameters" do
      Paypal::Notification.should_receive( :new ).with( 'stuff=things' )
      post :ipns, stuff: 'things'
    end
    
    it "finds the order matching the IPN's invoice number" do
      notification.should_receive( :invoice ).and_return( 25 )
      Order.should_receive( :find ).with( 25 )
      post :ipns
    end
    
    it "verifies the IPN with PayPal" do
      notification.should_receive( :acknowledge )
      post :ipns
    end
    
    context "if the IPN is successfully acknowledged" do
      before { notification.stub acknowledge: true }
         
      context "and the notification has Completed status with a total matching the order total" do
        before do 
          notification.stub complete?: true, gross: "36"
          order.stub line_total: "36".to_money
        end
        
        it "creates a successful OrderTransaction with the details" do
          OrderTransaction.should_receive( :create! ).with( order:     order, 
                                                            success:   true, 
                                                            amount:    order.total,
                                                            reference: nil,
                                                            action:    "purchase",
                                                            params:    { "mc_shipping"=>"12", "tax"=>"12" },
                                                            payment_service: 'PayPal WPS' )
          post :ipns, mc_shipping: "12", tax: "12"
        end
        
        it "creates OrderAdjustments for PayPal's shipping, tax, and fee" do
          OrderAdjustment.should_receive( :create! ).with( message: "PayPal-Calculated Shipping", amount: "12", order: order )
          OrderAdjustment.should_receive( :create! ).with( message: "PayPal-Calculated Tax", amount: "12", order: order )
          OrderAdjustment.should_receive( :create! ).with( message: "PayPal Transaction Fee", amount: "-1", order: order )
          
          post :ipns, mc_shipping: "12", tax: "12", mc_fee: "1"
        end
        
        it "purchases the order" do
          order.should_receive( :purchase! )
          post :ipns, mc_shipping: "12", tax: "12"
        end
        
        context "if the order is purchased successfully" do
          before { order.stub purchase!: true }
          
          it "sends confirmation E-Mails to the patron and artisan" do
            OrderMailer.stub_chain( :patron_order_confirmation_email, :deliver )
            OrderMailer.stub_chain( :artisan_order_receipt_email, :deliver )
            
            OrderMailer.should_receive( :patron_order_confirmation_email ).with( order, @frame )
            OrderMailer.should_receive( :artisan_order_receipt_email ).with( order, @frame )
            
            post :ipns, mc_shipping: "12", tax: "12"
          end
        end
      end
    
      context "if the notification does not have Completed status or the order total does not match the IPN total" do
        before { notification.stub complete?: false }
        
        it "creates a failed OrderTransaction with the details" do
          OrderTransaction.should_receive( :create! ).with( order: order, success: false, params: {}, payment_service: 'PayPal WPS' )
          post :ipns
        end
        
        it "fails the order" do
          order.should_receive( :fail! )
          post :ipns
        end
      end
    end
    
    context "if the IPN is not succesfully acknowledged" do
      it "creates a failed OrderTransaction with the details" do
        OrderTransaction.should_receive( :create! ).with( order: order, success: false, params: {}, payment_service: 'PayPal WPS' )
        post :ipns
      end
      
      it "fails the order" do
        order.should_receive( :fail! )
        post :ipns
      end
    end
  end
end