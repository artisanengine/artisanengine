require 'spec_helper'

describe Adjustment do
  let( :adjustment ) { Adjustment.new }

  describe "#amount_to_capture" do
    it "raises a NotImplemented error - this should be overridden by a subclass" do
      expect { adjustment.amount_to_capture }.to raise_error( NotImplementedError )
    end
  end
  
  describe "#default_message" do
    it "returns a default message" do
      adjustment.default_message.should == "Adjustment"
    end
  end
end