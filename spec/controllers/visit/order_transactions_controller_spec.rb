require 'spec_helper'
include ActiveMerchant::Billing::Integrations

describe Visit::OrderTransactionsController do
  before { Frame.generate domain: 'test.host' }
  
  describe "#ipns" do
    let( :notification ) { mock 'PaypalNotification' }
    let( :order )        { stub_model Order }
    
    before do 
      Order.stub find: order
      
      Paypal::Notification.stub new: notification
      notification.stub :acknowledge
      notification.stub :invoice
      notification.stub :complete?
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
        before { notification.stub complete?: true }
        
        it "creates a successful OrderTransaction with the details" do
          OrderTransaction.should_receive( :create! ).with( order: order, success: true )
          post :ipns
        end
        
        it "purchases the order" do
          order.should_receive( :purchase! )
          post :ipns
        end
      end
    
      context "if the notification does not have Completed status or the order total does not match the IPN total" do
        before { notification.stub complete?: false }
        
        it "creates a failed OrderTransaction with the details" do
          OrderTransaction.should_receive( :create! ).with( order: order, success: false )
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
        OrderTransaction.should_receive( :create! ).with( order: order, success: false )
        post :ipns
      end
      
      it "fails the order" do
        order.should_receive( :fail! )
        post :ipns
      end
    end
  end
end