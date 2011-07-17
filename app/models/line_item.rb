class LineItem < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations & Delegations
  
  belongs_to :variant
  belongs_to :order
  
  delegate   :name, to: :variant
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :variant, :order
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_create :capture_variant_price
  after_save    :destroy_if_quantity_is_0
  
  # ------------------------------------------------------------------
  # Money
  
  composed_of :price, class_name:  "Money",
                      mapping:     [ %w(price_in_cents cents), %w(currency currency_as_string) ],
                      constructor: lambda { |cents, currency| Money.new( cents || 0, currency || Money.default_currency ) },
                      converter:   lambda { |value| value.respond_to?( :to_money ) ? value.to_money : 0.to_money }
  
  # ------------------------------------------------------------------
  # Methods
  
  def options
    variant.values_to_s( false )
  end
  
  # ------------------------------------------------------------------                    
  private
  
  def capture_variant_price
    self.price = variant.price
  end
  
  def destroy_if_quantity_is_0
    destroy if quantity == 0
  end
end
