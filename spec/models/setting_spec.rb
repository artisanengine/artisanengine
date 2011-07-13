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
end
