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

  context "callbacks: " do
    context "before saving: " do
      it "creates a blog using its name" do
        frame = Frame.generate name: 'Rockadoodle'
        frame.blog.name.should == "Rockadoodle Blog"
      end
    end
  end
  
  context "methods: " do
    describe "#protected?" do
      it "returns true if it has a Password Protected setting" do
        frame = Frame.generate
        frame.settings << Setting.spawn( name: 'Password Protected', value: 'Yes' )
        
        frame.protected?.should be_true
      end
    end
  end
end
