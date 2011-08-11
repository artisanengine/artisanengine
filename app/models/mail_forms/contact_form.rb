class ContactForm < MailForm::Base
  # Accessors to set headers from the controller.
  attr_accessor :subject, :to, :from
  
  attribute :name,                  validate: true
  attribute :email
  attribute :city
  attribute :state
  attribute :zip
  attribute :place_of_purchase
  attribute :emmys_product
  attribute :best_by_date
  attribute :comments
    
  def headers
    {
      subject: self.subject,
      to:      self.to,
      from:    'noreply@artisanengine.com'
    }
  end
  
end