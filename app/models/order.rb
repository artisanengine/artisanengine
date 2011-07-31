# An order represents a real-world order. It can be adjusted with Adjustments.
# It also contains logic for creating addresses and patrons based on the
# information given to it during the checkout process, and a state machine
# for firing events based on its status.
class Order < ActiveRecord::Base
  attr_accessor :email, :subscribed
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  belongs_to :patron
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :billing_address,  class_name: 'Address'
  
  has_many   :adjustments,        as:      :adjustable,             dependent: :destroy
  has_many   :fulfillments,       through: :line_items, uniq: true, dependent: :destroy
  has_many   :line_items,                                           dependent: :destroy
  has_many   :order_transactions,                                   dependent: :destroy
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :frame
  validates_associated  :shipping_address
  validates_associated  :billing_address
  
  # ------------------------------------------------------------------
  # Scopes
  
  scope :except_new, lambda { where( "orders.status != ?", 'new' ) }
  
  # ------------------------------------------------------------------
  # Overrides
  
  # Orders are meant to be accessed primarily via their id_in_frame. 
  # However, new orders don't have one yet, so they use their regular
  # ID.
  def to_param
    new? ? id.to_s : id_in_frame.to_s
  end
  
  # ------------------------------------------------------------------
  # State Machine
  
  state_machine :status, initial: :new do
    state :new
    
    event :checkout! do
      transition :new     => :pending
      transition :pending => :pending
    end
    
    # A pending order must have a valid E-Mail and associated shipping
    # and billing addresses.
    state :pending do
      validates_presence_of :email, :shipping_address, :billing_address
      validates_format_of   :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    end
    
    after_transition :new     => :pending, :do => [ :associate_patron, :set_id_in_frame! ]
    after_transition :pending => :pending, :do => :associate_patron
    
    event :purchase! do
      transition :pending => :purchased
    end
    
    state :purchased
    
    event :fail! do
      transition all => :failed
    end
    
    state :failed
  end
  
  # ------------------------------------------------------------------
  # Methods
  
  # Manage a "courtesy" ID column that is set only for non-new orders and 
  # only looks at other orders in the frame.
  def set_id_in_frame!
    last_in_frame = Order.where( "orders.frame_id = ? AND orders.id_in_frame IS NOT NULL", frame.id )
                         .order( "orders.id_in_frame DESC" )
                         .first
    
    if last_in_frame
      self.id_in_frame = last_in_frame.id_in_frame + 1
      save
    else
      self.id_in_frame = 1001
      save
    end
  end
  
  # Used primarily by the LineItemsController. 
  # Initializes and return a new line item in the order using a variant ID.
  def line_item_from( variant_id = nil, options = {} )
    variant_id ? initialize_line_item_with_variant( variant_id, options ) : line_items.build
  end
  
  # Return the order total before any adjustments have been calculated for
  # itself or its line items.
  def unadjusted_total
    total = Money.new( 0, 'USD' )
    
    for line_item in line_items
      total += ( line_item.price * line_item.quantity )
    end
    
    total
  end
  
  # Return the final order total after line item prices have been calculated
  # and adjustments have been made.
  def adjusted_total
    total = unadjusted_total
    
    for adjustment in adjustments
      total += adjustment.amount
    end
    
    total
  end
  
  # Determine what proportion of an order's line items are fulfilled.
  def fulfillment_status
    return "Not Fulfilled"       if line_items.fulfilled.count == 0
    return "Fulfilled"           if line_items.fulfilled.count == line_items.count
    return "Partially Fulfilled" if line_items.fulfilled.count  < line_items.count and line_items.fulfilled.count != 0
  end
  
  # ------------------------------------------------------------------
  # Address Management
  
  # If an address exists with all the same attributes as an existing address, 
  # we should use that address instead.
  def shipping_address=( address )
    return unless address and address.is_a? Address
       
    duplicate_address = Address.where( frame_id:    address.frame_id,
                                       first_name:  address.first_name,
                                       last_name:   address.last_name,
                                       address_1:   address.address_1,
                                       address_2:   address.address_2,
                                       city:        address.city,
                                       province:    address.province,
                                       country:     address.country,
                                       postal_code: address.postal_code ).first
                   
    if duplicate_address
      self.shipping_address_id = duplicate_address.id
    else
      address.save
      self.shipping_address_id = address.id
    end
  end
  
  # If an address exists with all the same attributes as an existing address, 
  # we should use that address instead.
  def billing_address=( address )   
    return unless address and address.is_a? Address
    
    duplicate_address = Address.where( frame_id:    address.frame_id,
                                       first_name:  address.first_name,
                                       last_name:   address.last_name,
                                       address_1:   address.address_1,
                                       address_2:   address.address_2,
                                       city:        address.city,
                                       province:    address.province,
                                       country:     address.country,
                                       postal_code: address.postal_code ).first
                   
    if duplicate_address
      self.billing_address_id = duplicate_address.id
    else
      address.save
      self.billing_address_id = address.id
    end
  end
  
  # ------------------------------------------------------------------
  private
  
  # Check if a line item already exists with the given variant ID. If so, just return
  # that line item with an incremented quantity. Otherwise, initialize a new one.
  def initialize_line_item_with_variant( variant_id, options = {} )
    init_quantity = options[ :quantity ].to_i
    init_quantity = 1 if init_quantity == 0
    
    duplicate_line_item           = line_items.where( variant_id: variant_id ).first
    duplicate_line_item.quantity += init_quantity and return duplicate_line_item if duplicate_line_item

    line_items.build variant_id: variant_id, quantity: init_quantity
  end
  
  # Find or create a patron based on their E-Mail, and associate any order addresses
  # with that patron.
  def associate_patron
    self.patron = Patron.find_or_create_by_email( email:       email,
                                                  first_name:  billing_address.first_name, 
                                                  last_name:   billing_address.last_name,
                                                  subscribed:  subscribed,
                                                  frame:       frame )
    
    patron.addresses << billing_address  unless patron.addresses.include? billing_address
    patron.addresses << shipping_address unless patron.addresses.include? shipping_address
    save
  end
end
