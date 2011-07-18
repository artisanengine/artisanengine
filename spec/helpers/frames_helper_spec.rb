require 'spec_helper'

describe FramesHelper do  
  describe "#current_frame" do
    let( :requested_frame ) { stub Frame }
    let( :forced_frame )    { stub Frame }
    
    context "if the requested domain is artisanengine" do
      before { controller.stub_chain( :request, :domain ).and_return( 'artisanengine.com' ) }
      
      context "and there is a subdomain" do
        before { controller.stub_chain( :request, :subdomain ).and_return( 'emmysorganics' ) }
        
        it "returns the frame matching the subdomain + .com" do
          Frame.should_receive( :find_by_domain )
               .with( 'emmysorganics.com' )
               .and_return( requested_frame )
          
          helper.current_frame.should == requested_frame
        end
      end
    end
    
    context "if a frame matching the requested domain is found" do
      it "returns the frame matching the requested domain" do
        Frame.should_receive( :find_by_domain )
             .with( 'test.host' )
             .and_return( requested_frame )
        
        helper.current_frame.should == requested_frame
      end
      
      it "prioritizes a forced frame over a normally requested frame" do
        ENV[ "FORCE_FRAME" ] = 'hausleather.com'

        Frame.should_receive( :find_by_domain )
             .with( 'hausleather.com' )
             .and_return( forced_frame )

        helper.current_frame.should == forced_frame
      end
    end

    context "if no frame matching the requested domain is found" do
      it "raises a RoutingError" do
        Frame.should_receive( :find_by_domain ).and_return( nil )
        
        expect {
          helper.current_frame
        }.to raise_error ActionController::RoutingError
      end
    end
  end

  describe "#google_analytics_account" do
    let( :frame ) { stub_model Frame }
    before        { helper.stub current_frame: frame }
    
    context "if the frame has a Google Analytics account set" do
      it "returns the account" do
        Setting.should_receive( :get_or_set )
               .with( frame, 'Google Analytics' )
               .and_return( 'ABC-123' )
               
        helper.google_analytics_account.should == 'ABC-123'
      end
    end
    
    context "if the frame does not have a Google Analytics account set" do
      it "returns nil" do
        Setting.should_receive( :get_or_set )
               .with( frame, 'Google Analytics' )
               
        helper.google_analytics_account.should be_nil
      end
    end
  end 
  
  describe "#password_protected_frame?" do
    let( :frame ) { stub_model Frame }
    before        { helper.stub current_frame: frame }
    
    context "if the current frame is Password Protected" do
      it "returns true" do
        Setting.should_receive( :get_or_set )
               .with( frame, 'Password Protected' )
               .and_return( 'Yes' )
               
        helper.password_protected_frame?.should be_true
      end
    end
    
    context "if the current frame is not Password Protected" do
      it "returns false" do
        Setting.should_receive( :get_or_set )
               .with( frame, 'Password Protected' )
               
        helper.password_protected_frame?.should be_false
      end
    end
  end
end