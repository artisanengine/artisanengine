require 'spec_helper'

describe Patron do
  let( :new_patron ) { Patron.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_patron.should be_valid
    end
    
    it "is not valid without an E-Mail" do
      new_patron.email = nil
      new_patron.should_not be_valid
    end
    
    it "is not valid with an improperly formatted E-Mail" do
      invalid_emails = [ "suckit", "nota@valid", "notavalid.email", "inv@ali*^d.net" ]

      for invalid_email in invalid_emails
        new_patron.email = invalid_email
        new_patron.should_not be_valid
      end
    end
  end
end