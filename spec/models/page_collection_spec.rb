require 'spec_helper'

describe PageCollection do
  let( :new_page_collection ) { PageCollection.new name: "A Collection", frame: stub_model( Frame ) }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_page_collection.should be_valid
    end
    
    it "is not valid without a frame" do
      new_page_collection.frame = nil
      new_page_collection.should_not be_valid
    end
    
    it "is not valid without a name" do
      new_page_collection.name = nil
      new_page_collection.should_not be_valid
    end
  end
end