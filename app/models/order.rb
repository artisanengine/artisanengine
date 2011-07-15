class Order < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :line_items
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :frame
  
  # ------------------------------------------------------------------
  # State Machine
  
  state_machine :status, initial: :new
  
  # ------------------------------------------------------------------
  # Methods
  
  def line_item_from( variant_id = nil )
    variant_id ? initialize_line_item_with_variant( variant_id ) : line_items.build
  end
  
  def line_total
    total = Money.new( 0, 'USD' )
    
    for line_item in line_items
      total += ( line_item.price * line_item.quantity )
    end
    
    total
  end
  
  # ------------------------------------------------------------------
  private
  
  def initialize_line_item_with_variant( variant_id )
    duplicate_line_item           = line_items.where( variant_id: variant_id ).first
    duplicate_line_item.quantity += 1 and return duplicate_line_item if duplicate_line_item

    line_items.build variant_id: variant_id
  end
end
