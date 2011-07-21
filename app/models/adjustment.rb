class Adjustment < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :adjustable, polymorphic: true
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :adjustable, :message
  validate              :amount_is_not_0
  
  # ------------------------------------------------------------------
  # Money

  composed_of :amount, class_name:  "Money",
                       mapping:     [ %w(amount_in_cents cents), %w(currency currency_as_string) ],
                       constructor: lambda { |cents, currency| Money.new( cents || 0, currency || Money.default_currency ) },
                       converter:   lambda { |value| value.respond_to?( :to_money ) ? value.to_money : 0.to_money }

  
  # ------------------------------------------------------------------
  private
  
  def amount_is_not_0
    errors.add :amount, "cannot be 0" if amount.zero?
  end
end
