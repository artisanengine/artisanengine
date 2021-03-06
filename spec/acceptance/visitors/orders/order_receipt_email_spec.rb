require 'acceptance/acceptance_helper'

feature "Order Receipt E-Mail", %q{
  In order to be notified about incoming orders
  As an artisan
  I want to receive an E-Mail when a paid order is received.
} do
  
  background do
    # Clear any existing deliveries.
    ActionMailer::Base.deliveries.clear
    
    # And the test frame has an artisan,
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
  
  scenario "An artisan receives an E-Mail when an order is paid for" do
    # Then the artisan should receive an E-Mail.
    ActionMailer::Base.deliveries.should_not be_empty
  
    email = ActionMailer::Base.deliveries[1]
    
    email.from.should    include 'noreply@artisanengine.com'
    email.to.should      include 'varamyr@sixskins.com'
    email.subject.should == 'You have received an order!'
    
    email.encoded.should =~ /You have received a paid order for the following items/
    email.encoded.should =~ /Bandana/
    email.encoded.should =~ /Saddle/
    email.encoded.should =~ /Six Shooter/
    email.encoded.should =~ /You can view and manage this order's details/
    email.encoded.should =~ /ae.test\/manage\/orders/
    email.encoded.should =~ /ArtisanEngine/
  end
end