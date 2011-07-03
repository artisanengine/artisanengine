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
    
    it "is not valid with a blank required option value" do
      good    = Good.generate # Generates one option and one variant by default.
      variant = good.variants.new( option_value_1: '' )
      
      variant.should_not be_valid
    end
    
    it "is not valid with less option values than its good has options" do
      good    = Good.generate # Generates one option and one variant by default.
      variant = good.variants.new
  
      variant.should_not be_valid
    end
    
    it "is not valid with more option values than its good has options" do
      good    = Good.generate # Generates one option and one variant by default.
      variant = good.variants.new( option_value_1: 'Set', option_value_2: 'Set' )
      
      variant.should_not be_valid
    end
  end
end
