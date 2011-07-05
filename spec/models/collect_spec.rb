require 'spec_helper'

describe Collect do
  let( :new_collect ) { Collect.new good:         stub_model( Good ),
                                    display_case: stub_model( DisplayCase ) }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_collect.should be_valid
    end
    
    it "is not valid without a display case" do
      new_collect.display_case = nil
      new_collect.should_not be_valid
    end
    
    it "is not valid without a good" do
      new_collect.good = nil
      new_collect.should_not be_valid
    end
  end
end
