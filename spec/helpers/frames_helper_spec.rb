require 'spec_helper'

describe FramesHelper do  
  describe "#current_frame" do 
    context "if a frame matching the requested domain is found" do
      let( :requested_frame ) { stub 'Frame' }
      
      it "returns the frame matching the request domain" do
        Frame.should_receive( :find_by_domain )
             .with( 'test.host' )
             .and_return( requested_frame )
        
        helper.current_frame.should == requested_frame
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
end