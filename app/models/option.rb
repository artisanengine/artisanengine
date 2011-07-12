class Option < ActiveRecord::Base
  attr_accessible :name, :default_value
  
  # ------------------------------------------------------------------
  # Callbacks
  
  after_create          :update_good_variants_with_default_value
  before_destroy        :ensure_not_last_option
  before_destroy        :shift_lower_positioned_options_higher
  
  # ------------------------------------------------------------------
  # Positioning
  
  acts_as_list column: :order_in_good, scope: :good
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :good

  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :good, :name, :default_value
  validate              :good_has_less_than_5_options

  # ------------------------------------------------------------------
  # Methods
  
  def shift_higher
    for variant in good.variants
      eval( "variant.option_value_#{ order_in_good - 1 } = variant.option_value_#{ order_in_good }" )
    
      # Clear Option Value 3.
      eval( "variant.option_value_#{ order_in_good } = nil" )
    
      # Save the variant. Do not validate, since one of the required option values
      # may temporarily be nil if other options are waiting to be shifted.
      variant.save!( validate: false )
    end
  end
  
  # ------------------------------------------------------------------
  # Scopes

  scope :in_order, order( "options.order_in_good ASC" )
  
  # ------------------------------------------------------------------
  private
    
  def shift_lower_positioned_options_higher
    Option.transaction do
      for option in good.options.where( "options.order_in_good > #{ order_in_good }" ).all
        option.shift_higher
      end
    end
  end
  
  def update_good_variants_with_default_value
    good.variants.update_all( :"option_value_#{ order_in_good }" => default_value )
  end
  
  def good_has_less_than_5_options
    errors.add( :good, "cannot have more than 5 options" ) if good and good.options.count == 5
  end
  
  def ensure_not_last_option
    return false if good.options.count == 1
  end
end
