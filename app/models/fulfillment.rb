class Fulfillment < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :order
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :order, :shipping_method
  
  # ------------------------------------------------------------------
  # Money
  
  composed_of :cost, class_name:  "Money",
                     mapping:     [ %w(cost_in_cents cents), %w(currency currency_as_string) ],
                     constructor: lambda { |cents, currency| Money.new( cents || 0, currency || Money.default_currency ) },
                     converter:   lambda { |value| value.respond_to?( :to_money ) ? value.to_money : 0.to_money }
end
