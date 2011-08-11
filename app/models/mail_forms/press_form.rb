class PressForm < MailForm::Base
  # Accessors to set headers from the controller.
  attr_accessor :subject, :to, :from
  
  attribute :name,                  validate: true
  attribute :email
  attribute :title
  attribute :publication_or_website
  attribute :your_deadline
  attribute :phone
  attribute :comments
    
  def headers
    {
      subject: self.subject,
      to:      self.to,
      from:    'noreply@artisanengine.com'
    }
  end
  
end