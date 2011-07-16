require 'spec_helper'

describe OrderTransaction do
  let( :new_transaction ) { OrderTransaction.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_transaction.should be_valid
    end
    
    it "is not valid without an order" do
      new_transaction.order = nil
      new_transaction.should_not be_valid
    end
  end
end
