require 'spec_helper'

describe Tagging do
  let( :new_tagging ) { Tagging.new }
  
  context "validations: " do
    it "is not valid without a tag" do
      new_tagging.tag = nil
      new_tagging.should_not be_valid
    end
    
    it "is not valid without a taggable" do
      new_tagging.taggable = nil
      new_tagging.should_not be_valid
    end
  end
end
