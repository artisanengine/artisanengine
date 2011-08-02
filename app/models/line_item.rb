# Line items represent a single item in an order. They can be fulfilled
# with Fulfillments and adjusted with Adjustments. 
class LineItem < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :fulfillment
  belongs_to :order
  belongs_to :variant
  
  delegate   :weight, to: :variant, allow_nil: true

  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :variant, :order
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_create :capture_variant_attributes
  after_save    :destroy_if_quantity_is_0
  
  # ------------------------------------------------------------------
  # Scopes
  
  scope :fulfilled,   lambda { where( "line_items.fulfillment_id IS NOT NULL" ) }
  scope :unfulfilled, lambda { where( "line_items.fulfillment_id IS NULL"     ) }
  
  # ------------------------------------------------------------------
  # Money
  
  composed_of :price, class_name:  "Money",
                      mapping:     [ %w(price_in_cents cents), %w(currency currency_as_string) ],
                      constructor: lambda { |cents, currency| Money.new( cents || 0, currency || Money.default_currency ) },
                      converter:   lambda { |value| value.respond_to?( :to_money ) ? value.to_money : 0.to_money }
    
  # ------------------------------------------------------------------                    
  private
  
  # Capture the variant attributes used to create this line item
  # in case the variant gets deleted in the future.
  def capture_variant_attributes
    self.price   = variant.price
    self.options = variant.values_to_s( false )
    self.name    = variant.name
  end
  
  # Destroy the line item if it is saved with a quantity of 0.
  def destroy_if_quantity_is_0
    destroy if quantity == 0
  end
end
