class DonationsForm < MailForm::Base
  # Accessors to set headers from the controller.
  attr_accessor :subject, :to, :from
  
  attribute :name,                  validate: true
  attribute :email
  attribute :phone
  attribute :organization
  attribute :event_name
  attribute :event_date
  attribute :number_of_attendees
  attribute :product_for_donation
  attribute :event_description
    
  def headers
    {
      subject: self.subject,
      to:      self.to,
      from:    'noreply@artisanengine.com'
    }
  end
  
end