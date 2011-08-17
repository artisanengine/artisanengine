require 'spec_helper'

describe Promotion do
  let( :new_promotion ) { Promotion.new promotional_code: "ABC-123",
                                        discount_amount:  10,
                                        discount_type:    Promotion::DISCOUNT_TYPES.first,
                                        discount_target:  Promotion::DISCOUNT_TARGETS.first }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_promotion.should be_valid
    end
    
    it "is not valid without a promotional code" do
      new_promotion.promotional_code = nil
      new_promotion.should_not be_valid
    end
    
    it "is not valid without a discount amount" do
      new_promotion.discount_amount = nil
      new_promotion.should_not be_valid
    end
    
    it "is not valid without a discount type" do
      new_promotion.discount_type = nil
      new_promotion.should_not be_valid
    end
    
    it "is not valid without a discount target" do
      new_promotion.discount_target = nil
      new_promotion.should_not be_valid
    end
  end
end
