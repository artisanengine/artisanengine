shared_examples_for "an adjustment model" do
  context "validations: " do
    it "is valid with valid attributes" do
      adjustment_model.should be_valid
    end
    
    it "is not valid without an adjustable" do
      adjustment_model.adjustable = nil
      adjustment_model.should_not be_valid
    end
  end
  
  context "callbacks: " do
    let( :adjustment ) { adjustment_model.class.new }
    before { adjustment.stub default_message: "Default Message" }
    
    describe "before validation: " do
      before { adjustment.stub :amount_to_capture }
      
      it "captures its amount using the #amount_to_capture method" do
        adjustment.stub amount_to_capture: 25
        adjustment.should_receive( :amount= ).with( 25 )
        adjustment.save
      end
      
      context "if a message has not been set" do
        it "sets a default message" do
          adjustment.should_receive( :message= ).with( "Default Message" )
          adjustment.save
        end
      end
      
      context "if a message has been set" do
        it "does not set the default message" do
          adjustment.message = "Custom Message"
          adjustment.should_not_receive( :message= )
          adjustment.save
        end
      end
    end
  end
end