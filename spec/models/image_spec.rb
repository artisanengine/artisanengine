require 'spec_helper'

describe Image do
  let( :new_image ) { Image.spawn }
  
  context "validations: " do
    it "is valid with valid attributes" do
      new_image.should be_valid
    end
    
    it "is not valid without a frame" do
      new_image.frame = nil
      new_image.should_not be_valid
    end
    
    it "is not valid without an image file" do
      new_image.image = nil
      new_image.should_not be_valid
    end
    
    it "is not valid with an image not of format .jpg, .jpeg, .png, or .gif" do
      new_image.image = File.new( "#{ Rails.root }/app/models/image.rb" )
      new_image.should_not be_valid
    end
  end
end