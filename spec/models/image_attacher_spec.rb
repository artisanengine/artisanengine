require 'spec_helper'

describe ImageAttacher do
  let( :new_image_attacher ) { ImageAttacher.new }
  
  context "validations: " do
    it "is not valid without an image" do
      new_image_attacher.image = nil
      new_image_attacher.should_not be_valid
    end
    
    it "is not valid without an imageable" do
      new_image_attacher.imageable = nil
      new_image_attacher.should_not be_valid
    end
  end    
end
