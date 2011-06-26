require 'spec_helper'

describe User do
  let( :new_user ) { Factory.build :user }
  
  context "validations: " do
    it "is not valid without a first name" do
      new_user.first_name = nil
      new_user.should_not be_valid
    end
    
    it "is not valid without a last name" do
      new_user.last_name = nil
      new_user.should_not be_valid
    end
    
    it "is not valid without an E-Mail" do
      new_user.email = nil
      new_user.should_not be_valid
    end
    
    it "is not valid without a unique E-Mail (scoped to frame)" do
      existing_user  = Factory :user
      
      # Valid with E-Mail in different frame.
      new_user.email = existing_user.email
      new_user.should be_valid
      
      # Invalid with E-Mail in same frame.
      new_user.frame = existing_user.frame
      new_user.should_not be_valid
    end
    
    it "is not valid with an improperly formatted E-Mail" do
      invalid_emails = [ "suckit", "nota@valid", "notavalid.email", "inv@ali*^d.net" ]

      for invalid_email in invalid_emails
        new_user.email = invalid_email
        new_user.should_not be_valid
      end
    end
    
    it "is not valid without a frame" do
      new_user.frame = nil
      new_user.should_not be_valid
    end
    
    it "exception: is valid without a frame if role is engineer" do
      new_user.frame = nil
      new_user.role = 'Engineer'
      new_user.should be_valid
    end
  end
end