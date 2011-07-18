require 'acceptance/acceptance_helper'

feature "Order Confirmation E-Mail", %q{
  In order to confirm that my order was paid for
  As a patron
  I want to receive an E-Mail when I pay for an order.
} do
  
  background do
    # Clear any existing deliveries.
    ActionMailer::Base.deliveries.clear
    
    # Given there is a frame with an artisan,
    use_frame( 'ae.test' ).artisans << Artisan.spawn( email: 'varamyr@sixskins.com' )
    
    # Given there are three goods,
    Good.generate name: 'Bandana'
    Good.generate name: 'Saddle'
    Good.generate name: 'Six Shooter'
    
    # And I have ordered the goods, checked out, and paid,
    add_to_order 'Bandana'
    add_to_order 'Saddle'
    add_to_order 'Six Shooter'
    
    checkout as: 'billy.thekid@varmints.net'
    simulate_ipn
  end
  
  scenario "A patron receives an E-Mail when an order is paid for" do
    # Then the patron should receive an E-Mail.
    ActionMailer::Base.deliveries.should_not be_empty

    email = ActionMailer::Base.deliveries.first
    
    email.from.should    include 'noreply@ae.test'
    email.to.should      include 'billy.thekid@varmints.net'
    email.subject.should == 'Thank you for your order!'
    
    email.encoded.should =~ /We have received payment for the following items/
    email.encoded.should =~ /Bandana/
    email.encoded.should =~ /Saddle/
    email.encoded.should =~ /Six Shooter/
    email.encoded.should =~ /You will receive a confirmation when your items ship/
    email.encoded.should =~ /Test Frame/
  end
end