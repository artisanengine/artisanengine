require 'spec_helper'

describe UserSessionsHelper do  
  describe "#current_user" do
    it "attempts to find the current UserSession" do
      UserSession.should_receive( :find )
      helper.current_user
    end
    
    context "if a matching session exists" do
      let( :matching_session ) { stub UserSession }
      let( :session_user )     { stub User }
      
      before { UserSession.stub find: matching_session }
      
      it "returns the user from the session" do
        matching_session.should_receive( :user ).and_return( session_user )
        helper.current_user.should == session_user
      end
    end
    
    context "if a session does not exist" do
      before { UserSession.stub find: nil }
      
      it "returns nil" do
        helper.current_user.should be_nil
      end
    end
  end
end