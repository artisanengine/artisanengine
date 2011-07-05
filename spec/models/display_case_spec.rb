require 'spec_helper'

describe DisplayCase do
  let( :new_display_case ) { DisplayCase.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_display_case.should be_valid
    end
    
    it "is not valid without a frame" do
      new_display_case.frame = nil
      new_display_case.should_not be_valid
    end
    
    it "is not valid without a name" do
      new_display_case.name = nil
      new_display_case.should_not be_valid
    end
  end
end
