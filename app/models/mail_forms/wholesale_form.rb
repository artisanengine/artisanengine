class WholesaleForm < MailForm::Base
  # Accessors to set headers from the controller.
  attr_accessor :subject, :to, :from
  
  BUSINESS_STATUSES = [ "New Business", "Existing Business" ]
  
  attribute :name,                  validate: true
  attribute :email
  attribute :city
  attribute :state
  attribute :zip
  attribute :company
  attribute :phone
  attribute :business_status
  attribute :comments
    
  def headers
    {
      subject: self.subject,
      to:      self.to,
      from:    'noreply@artisanengine.com'
    }
  end
  
end