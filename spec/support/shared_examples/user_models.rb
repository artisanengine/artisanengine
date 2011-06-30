shared_examples_for "a user model with validated E-Mail and password" do
  it "is not valid without a password" do
    user_model.password = nil
    user_model.should_not be_valid
  end
  
  it "is not valid without a matching password confirmation" do
    user_model.password_confirmation = 'nomatch'
    user_model.should_not be_valid
  end
  
  it "is not valid without an E-Mail" do
    user_model.email = nil
    user_model.should_not be_valid
  end
     
  it "is not valid with an improperly formatted E-Mail" do
    invalid_emails = [ "suckit", "nota@valid", "notavalid.email", "inv@ali*^d.net" ]

    for invalid_email in invalid_emails
      user_model.email = invalid_email
      user_model.should_not be_valid
    end
  end
end