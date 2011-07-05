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
  
  context "callbacks: " do
    describe "before creating: " do
      context "if it is the only image attacher in the imageable: " do
        let( :imageable ) { stub_model Good }
        
        before { imageable.stub_chain( :image_attachers, :any? ).and_return( false ) }
        
        it "sets its position to 1" do          
          ia = ImageAttacher.create! imageable: imageable, image: Image.generate
          ia.position.should == 1
        end
      end
      
      context "if it is not the only image attacher in the attachable: " do
        before do
          @imageable = Good.generate
          @imageable.images << Image.generate
          @imageable.images << Image.generate
          @imageable.images << Image.generate
        end
          
        it "sets its position to 1 lower than the lowest positioned image attacher in the imageable" do
          attacher_3 = @imageable.image_attachers.last
          attacher_3.position.should be 3
        end
      end
      
      context "scopes: " do
        describe "#in_order" do
          it "returns the attachers in ascending order of position" do
            imageable        = Good.generate
            attacher_top     = ImageAttacher.create! imageable: imageable, image: Image.generate
            attacher_middle  = ImageAttacher.create! imageable: imageable, image: Image.generate
            attacher_bottom  = ImageAttacher.create! imageable: imageable, image: Image.generate

            imageable.image_attachers.in_order.should == [ attacher_top, attacher_middle, attacher_bottom ]
          end
        end
      end
    end
  end
end
