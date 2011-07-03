require 'spec_helper'

describe Variant do
  let( :new_variant ) { Variant.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_variant.should be_valid
    end
    
    it "is not valid without a good" do
      new_variant.good = nil
      new_variant.should_not be_valid
    end
  end
end
