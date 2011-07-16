require 'spec_helper'

describe Variant do
  let( :new_variant ) { Variant.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_variant.should be_valid
    end
    
    it "is not valid without a price greater than 1" do
      for invalid_price in [ -1, 0, 0.001 ]
        new_variant.price = invalid_price
        new_variant.should_not be_valid
      end
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
  
  context "callbacks: " do
    describe "before destroying: " do
      it "cannot be destroyed if it is its good's only variant" do
        good    = Good.generate
        variant = good.variants.first
        variant.destroy.should be_false
      end
    end
  end

  context "methods: " do
    describe "#values_to_s" do
      it "can return its values in a slash-separated string with price" do
        good    = Factory( :good_with_three_options_and_variants )
        variant = good.variants.first
        variant.update_attributes price: 25
      
        variant.values_to_s.should == "Small / Blue / Cloth -- $25.00"
      end
      
      it "can return its values in a slash-separated string without price" do
        good    = Factory( :good_with_three_options_and_variants )
        variant = good.variants.first
        
        variant.values_to_s( false ).should == "Small / Blue / Cloth"
      end
      
      it "returns nothing if its only value is the default value" do
        good    = Good.generate
        variant = good.variants.first
        
        variant.values_to_s.should == ""
      end
    end
  end
end
