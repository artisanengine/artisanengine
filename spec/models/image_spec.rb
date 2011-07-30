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
    
    it "is not valid with an improperly formatted image name" do
      new_image.image = File.new( "#{ Rails.root }/spec/support/images/m yst.jpeg" )
      new_image.should_not be_valid
    end
  end
 
  context "methods: " do
    describe "#name_or_filename" do
      context "if the image has a name" do
        let( :image ) { Image.generate name: 'Romeo' }
        
        it "returns the name" do
          image.name_or_filename.should == 'Romeo'
        end
      end
      
      context "if the image has no name" do
        let( :image ) { Image.generate name: "" }
        
        it "returns the image filename" do
          image.name_or_filename.should == image.image_name
        end
      end
    end
  end
    
  context "before saving: " do
    context "if all its crop values are set" do
      before do 
        new_image.crop_x = 5
        new_image.crop_y = 10
        new_image.crop_w = 15
        new_image.crop_h = 20
      end
      
      context "if the crop_priority attribute is 'primary'" do
        before { new_image.crop_priority = 'primary' }
        
        it "sets its primary cropping as an array" do
          new_image.save
          Image.last.primary_cropping.should == [ 5, 10, 15, 20 ]
        end
      end
      
      context "if the crop_priority attribute is 'secondary'" do
        before { new_image.crop_priority = 'secondary' }
        
        it "sets its secondary cropping as an array" do
          new_image.save
          Image.last.secondary_cropping.should == [ 5, 10, 15, 20 ]
        end
      end
      
      context "if the crop_priority attribute is not set to 'primary' or 'secondary'" do
        it "invalidates the image" do
          new_image.save.should be_false
          new_image.errors.count.should == 1
        end
      end
    end
  end        
end