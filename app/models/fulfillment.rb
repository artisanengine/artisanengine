class Fulfillment < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  has_many   :line_items
  belongs_to :order
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :order, :shipping_method
  validate              :at_least_one_line_item
  
  # ------------------------------------------------------------------
  # Money
  
  composed_of :cost, class_name:  "Money",
                     mapping:     [ %w(cost_in_cents cents), %w(currency currency_as_string) ],
                     constructor: lambda { |cents, currency| Money.new( cents || 0, currency || Money.default_currency ) },
                     converter:   lambda { |value| value.respond_to?( :to_money ) ? value.to_money : 0.to_money }

  # ------------------------------------------------------------------
  private
  
  def at_least_one_line_item
    errors.add( :base, "must fulfill at least one line item." ) unless line_items.any?
  end
end
