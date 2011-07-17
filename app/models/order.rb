class Order < ActiveRecord::Base
  attr_accessor :email, :subscribed
  
  # ------------------------------------------------------------------
  # Associations
  
  has_many   :line_items
  has_many   :order_transactions
  
  belongs_to :frame
  belongs_to :patron
  
  belongs_to                    :shipping_address, class_name: 'Address'
  validates_associated          :shipping_address
  
  belongs_to                    :billing_address, class_name: 'Address'
  validates_associated          :billing_address
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :frame
  
  # ------------------------------------------------------------------
  # Scopes
  
  scope :except_new, lambda { where( "orders.status != ?", 'new' ) }
  
  # ------------------------------------------------------------------
  # Overrides
  
  def to_param
    id_in_frame ? id_in_frame.to_s : id.to_s
  end
  
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
    
    after_transition :new     => :pending, :do => [ :set_patron, :set_id_in_frame! ]
    after_transition :pending => :pending, :do => :set_patron
    
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
  
  # Since New orders get created all the time and we don't want big gaps
  # in the order management screens, manage a "courtesy" ID column that
  # is set only for non-new orders and only looks at other orders in the
  # frame.
  def set_id_in_frame!
    last_in_frame = frame.orders.order( "orders.id_in_frame DESC" ).first
    
    if last_in_frame and last_in_frame.id_in_frame
      self.id_in_frame = last_in_frame.id_in_frame + 1
      save
    else
      self.id_in_frame = 1001
      save
    end
  end
  
  # Used by the LineItemsController, initialize and return a new line item in the order 
  # using a variant ID.
  def line_item_from( variant_id = nil )
    variant_id ? initialize_line_item_with_variant( variant_id ) : line_items.build
  end
  
  # Return the order total before any adjustments have been added or subtracted.
  def line_total
    total = Money.new( 0, 'USD' )
    
    for line_item in line_items
      total += ( line_item.price * line_item.quantity )
    end
    
    total
  end
  
  # Return the final order total after adjustments have been made.
  def total
    line_total
  end
  
  # ------------------------------------------------------------------
  # Setter Overrides
  
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
  def initialize_line_item_with_variant( variant_id )
    duplicate_line_item           = line_items.where( variant_id: variant_id ).first
    duplicate_line_item.quantity += 1 and return duplicate_line_item if duplicate_line_item

    line_items.build variant_id: variant_id
  end
  
  # Find or create a patron based on their E-Mail, and associate any order addresses
  # with that patron.
  def set_patron
    self.patron = Patron.find_or_create_by_email( email:       email,
                                                  first_name:  billing_address.first_name, 
                                                  last_name:   billing_address.last_name,
                                                  subscribed:  subscribed,
                                                  frame:       frame )
    
    patron.addresses << billing_address
    patron.addresses << shipping_address
    save
  end
end
