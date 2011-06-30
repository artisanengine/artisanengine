require 'spec_helper'

describe Artisan do
  let( :new_artisan ) { Artisan.spawn }
  
  context "validations: " do
    it_behaves_like "a user model with validated E-Mail and password" do
      let( :user_model ) { new_artisan }
    end
    
    it "is not valid without a first name" do
      new_artisan.first_name = nil
      new_artisan.should_not be_valid
    end
    
    it "is not valid without a last name" do
      new_artisan.last_name = nil
      new_artisan.should_not be_valid
    end
    
    it "is not valid without a frame" do
      new_artisan.frame = nil
      new_artisan.should_not be_valid
    end
  end
end