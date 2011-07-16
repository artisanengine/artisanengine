class Order < ActiveRecord::Base
  attr_accessor :email, :subscribed
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :line_items
  belongs_to :patron
  
  belongs_to                    :shipping_address, class_name: 'Address'
  accepts_nested_attributes_for :shipping_address
  validates_associated          :shipping_address
  
  belongs_to                    :billing_address, class_name: 'Address'
  accepts_nested_attributes_for :billing_address
  validates_associated          :billing_address
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :frame
  
  # ------------------------------------------------------------------
  # State Machine
  
  state_machine :status, initial: :new do
    state :new
    
    event :checkout! do
      transition :new     => :pending
      transition :pending => :pending
    end
    
    state :pending do
      validates_presence_of :email, :shipping_address, :billing_address
      validates_format_of   :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    end
    
    after_transition :new     => :pending, :do => :set_patron
    after_transition :pending => :pending, :do => :set_patron
  end
  
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
  
  def set_patron
    self.patron = Patron.find_or_create_by_email( email:       email,
                                                  first_name:  billing_address.first_name, 
                                                  last_name:   billing_address.last_name,
                                                  subscribed:  subscribed )
    save
  end
end
