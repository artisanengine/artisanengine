require 'spec_helper'

describe DollarAdjustment do
  it_behaves_like "an adjustment model" do
    let( :adjustment_model ) { DollarAdjustment.spawn }
  end
  
  context "methods: " do
    let( :dollar_adjustment ) { DollarAdjustment.spawn basis: 10 }
    
    describe "#amount_to_capture" do
      it "returns its basis" do
        dollar_adjustment.amount_to_capture.should == 10
      end
    end
  end
end