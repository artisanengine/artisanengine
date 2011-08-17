# Adjustments are applied to orders or line items to modify their price.
# For instance, applying a discount or adding shipping costs.
class Adjustment < ActiveRecord::Base
  attr_accessible :adjustable, :basis, :message, :promotion
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_validation :capture_amount
  before_validation :set_default_message, unless: :message
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :adjustable, polymorphic: true
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :adjustable

  # ------------------------------------------------------------------
  # Money

  composed_of :amount, class_name:  "Money",
                       mapping:     [ %w(amount_in_cents cents), %w(currency currency_as_string) ],
                       constructor: lambda { |cents, currency| Money.new( cents || 0, currency || Money.default_currency ) },
                       converter:   lambda { |value| value.respond_to?( :to_money ) ? value.to_money : 0.to_money }


  # ------------------------------------------------------------------
  # Methods
  
  # This should be overridden by a subclass. It is the amount of the adjustment
  # that is captured when the adjustment is added to an adjustable - so,
  # class-specific calculation logic goes in here.
  def amount_to_capture
    raise NotImplementedError, "#amount_to_capture has not been defined for #{ self.class }."
  end
  
  # This should be overridden by a subclass. It is the default message
  # for this type of adjustment.
  def default_message
    "Adjustment"
  end
  
  # ------------------------------------------------------------------
  private
    
  def capture_amount
    self.amount = amount_to_capture
  end
  
  def set_default_message
    self.message = default_message
  end
end
