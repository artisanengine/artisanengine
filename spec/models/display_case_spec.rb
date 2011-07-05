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
  
  context "callbacks: " do
    describe "before updating: " do
      it "cannot be updated if it is the Featured display case" do
        frame         = Frame.generate
        featured_case = frame.display_cases.first
        featured_case.name = "New Name"
        featured_case.save.should be_false
      end
    end
    
    describe "before destroying: " do
      it "cannot be destroyed if it is the Featured display case" do
        frame         = Frame.generate
        featured_case = frame.display_cases.first
        featured_case.destroy.should be_false
      end
    end
  end
end
