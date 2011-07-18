require 'spec_helper'

describe Visit::PatronsController do
  let( :patron ) { stub_model Patron }
  
  before do
    Frame.generate domain: 'test.host'
    Patron.stub find_or_initialize_by_email: patron
    request.env[ "HTTP_REFERER" ] = "back"
  end
  
  describe "POST /subscribe" do
    it "finds or initializes a patron using the given E-Mail" do
      Patron.should_receive( :find_or_initialize_by_email ).with( 'test@email.com' )
      post 'subscribe', email: 'test@email.com'
    end
    
    it "sets the patron's frame and sets its subscription status to true" do
      patron.should_receive( :frame= ).with( Frame.find_by_domain 'test.host' )
      patron.should_receive( :subscribed= ).with( true )
      post 'subscribe'
    end
      
    it "saves the patron" do
      patron.should_receive( :save )
      post 'subscribe'
    end
    
    context "if the patron saves successfully" do
      before { patron.stub save: true }
      
      it "sets the flash to a success message" do
        post 'subscribe'
        flash[ :subscribe_notice ].should =~ /thank you/i
      end
    end
    
    context "if the patron does not save successfully" do
      before { patron.stub save: false }
      
      it "sets the flash to a failure message" do
        post 'subscribe'
        flash[ :subscribe_notice ].should =~ /invalid/i
      end
    end
    
    it "redirects back to the referring page" do
      post 'subscribe'
      response.should redirect_to "back"
    end
  end
end