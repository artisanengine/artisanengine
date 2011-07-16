require 'spec_helper'

describe AddressAttacher do
  let( :new_address_attacher ) { AddressAttacher.new addressable: stub_model( Good ),
                                                     address:     Address.generate }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_address_attacher.should be_valid
    end
    
    it "is not valid without an address" do
      new_address_attacher.address = nil
      new_address_attacher.should_not be_valid
    end
    
    it "is not valid without an addressable" do
      new_address_attacher.addressable = nil
      new_address_attacher.should_not be_valid
    end
  end
end
