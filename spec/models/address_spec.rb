require 'spec_helper'

describe Address do
  let( :new_address ) { Address.spawn }
  
  context "validations:" do
    it "is valid with valid attributes" do
      new_address.should be_valid
    end
    
    it "is not valid without a frame" do
      new_address.frame = nil
      new_address.should_not be_valid
    end
    
    it "is not valid without a first name" do
      new_address.first_name = nil
      new_address.should_not be_valid
    end
    
    it "is not valid without a last name" do
      new_address.last_name = nil
      new_address.should_not be_valid
    end

    it "is not valid without an address_1" do
      new_address.address_1 = nil
      new_address.should_not be_valid
    end
    
    it "is not valid without a city" do
      new_address.city = nil
      new_address.should_not be_valid
    end
    
    it "is not valid without a country" do
      new_address.city = nil
      new_address.should_not be_valid
    end
    
    it "is not valid without a postal code" do
      new_address.postal_code = nil
      new_address.should_not be_valid
    end
  end
end