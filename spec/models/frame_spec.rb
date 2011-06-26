require 'spec_helper'

describe Frame do
  let( :new_frame ) { Frame.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_frame.should be_valid
    end
    
    it "is not valid without a name" do
      new_frame.name = nil
      new_frame.should_not be_valid
    end
    
    it "is not valid without a domain" do
      new_frame.domain = nil
      new_frame.should_not be_valid
    end
    
    it "is not valid without a unique domain" do
      existing_frame = Frame.generate domain: 'hausleather'
      new_frame      = Frame.spawn    domain: 'hausleather'
      
      new_frame.should_not be_valid
    end
  end
end
