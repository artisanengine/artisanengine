class LineItem < ActiveRecord::Base
  belongs_to :variant
  belongs_to :order
  delegate :name, to: :variant
  
  validates_presence_of :variant, :order
  
  before_create :capture_variant_price
  
  # ------------------------------------------------------------------
  # Money
  
  composed_of :price, class_name:  "Money",
                      mapping:     [ %w(price_in_cents cents), %w(currency currency_as_string) ],
                      constructor: lambda { |cents, currency| Money.new( cents || 0, currency || Money.default_currency ) },
                      converter:   lambda { |value| value.respond_to?( :to_money ) ? value.to_money : 0.to_money }

  private
  
  def capture_variant_price
    self.price = variant.price
  end
end
