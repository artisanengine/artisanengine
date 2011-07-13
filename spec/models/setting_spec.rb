require 'spec_helper'

describe Setting do
  let( :new_setting ) { Setting.generate }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_setting.should be_valid
    end
    
    it "is not valid without a frame" do
      new_setting.frame = nil
      new_setting.should_not be_valid
    end
    
    it "is not valid without a name" do
      new_setting.name = nil
      new_setting.should_not be_valid
    end
    
    it "is not valid without a value" do
      new_setting.value = nil
      new_setting.should_not be_valid
    end
  end
  
  context "methods: " do
    describe "#get_or_set" do
      let( :setting ) { Setting.generate name: 'Test Setting', value: 'Test Value' }
      let( :frame )   { setting.frame }
      
      it "finds the correct setting based on the frame and setting name" do
        Setting.get_or_set( frame, 'Test Setting' ).should == 'Test Value'
      end
      
      context "if no setting is found" do
        it "returns the default setting" do
          Setting.get_or_set( frame, 'Nonexistent Setting', 'Default' )
        end
      end
      
      context "if an environment override is set" do
        before { ENV[ "TEST_SETTING" ] = "Environment Value" }
        
        it "returns the environment setting" do
          Setting.get_or_set( frame, 'Test Setting', 'Default' )
                 .should == "Environment Value"
        end
      end
    end
  end
end
