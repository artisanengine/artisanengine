require 'spec_helper'

describe Option do
  let( :new_option ) { Option.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_option.should be_valid
    end
    
    it "is not valid without a good" do
      new_option.good = nil
      new_option.should_not be_valid
    end
    
    it "is not valid without a name" do
      new_option.name = nil
      new_option.should_not be_valid
    end
    
    it "is not valid without a default value" do
      new_option.default_value = nil
      new_option.should_not be_valid
    end
    
    it "is not valid if its good already has 5 options" do
      good       = Factory :good_with_5_options
      new_option = Option.spawn good: good
      
      new_option.should_not be_valid
    end
  end
  
  context "callbacks: " do
    describe "before creating: " do
      context "if it is the only option in the good: " do
        it "sets its position to 1 if it is the only option in the good" do
          good = Good.generate # Generates one option by default.
          good.options.first.position.should be 1
        end
      end
      
      context "if it is not the only option in the good: " do
        it "sets its position to 1 lower than the previous option in the good" do
          good     = Good.generate # Generates one option by default.
          option_2 = Option.generate good: good
          option_3 = Option.generate good: good
          
          option_3.position.should be 3
        end
      end
    end
    
    describe "after creating: " do
      it "initializes its good's variants' option values" do
        good = Good.generate # Generates one option with default_value: "Default" by default.
        good.variants.first.option_value_1.should == "Default"
      end
    end
    
    describe "before destroying: " do
      it "cannot be destroyed if it is the good's last option" do
        good   = Good.generate # Generates one option by default.
        option = good.options.first
        option.destroy.should be_false
      end
    end
  end
  
  context "scopes: " do
    describe "#in_order" do
      it "returns the options in ascending order of position" do
        good          = Good.generate # Generates one option by default.
        option_bottom = Option.generate good: good
        option_top    = Option.generate good: good
        option_middle = Option.generate good: good
        
        good.options.in_order.should == [ good.options.first, option_bottom, option_top, option_middle ]
      end
    end
  end
end
