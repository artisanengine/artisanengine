# OrderTransactions represent a payment received for an order (successful or
# not). It contains information such as the parameters sent by the payment
# service and the amount of the attempted transaction.
class OrderTransaction < ActiveRecord::Base
  serialize :params
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :order
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :order
  
  # ------------------------------------------------------------------
  # Money
  
  composed_of :amount, class_name:  "Money",
                       mapping:     [ %w(amount_in_cents cents), %w(currency currency_as_string) ],
                       constructor: lambda { |cents, currency| Money.new( cents || 0, currency || Money.default_currency ) },
                       converter:   lambda { |value| value.respond_to?( :to_money ) ? value.to_money : 0.to_money }
end
