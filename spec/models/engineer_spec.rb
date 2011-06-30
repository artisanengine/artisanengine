require 'spec_helper'

describe Engineer do
  let( :new_engineer ) { Engineer.spawn }
  
  context "validations: " do
    it_behaves_like "a user model with validated E-Mail and password" do
      let( :user_model ) { new_engineer }
    end
  end
end