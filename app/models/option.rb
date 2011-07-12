class Option < ActiveRecord::Base
  attr_accessible :name, :default_value
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_create         :set_position
  after_create          :update_good_variants_with_default_value
  before_destroy        :ensure_not_last_option
  after_destroy         :shift_lower_positioned_options_higher
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :good

  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :good, :name, :default_value
  validate              :good_has_less_than_5_options
  
  # ------------------------------------------------------------------
  # Scopes
  
  scope :in_order,       order( "options.position ASC" )
  
  # ------------------------------------------------------------------
  # Methods
  
  def shift_higher
    for variant in good.variants
      # Example: Shifting Option Value 3 higher.
      # Set Option Value 2 = Option Value 3
      eval( "variant.option_value_#{ position - 1 } = variant.option_value_#{ position }" )
    
      # Clear Option Value 3.
      eval( "variant.option_value_#{ position } = nil" )
    
      # Save the variant. Do not validate, since one of the required option values
      # may temporarily be nil if other options are waiting to be shifted.
      variant.save!( validate: false )
    end

    # Set option position to one higher.
    self.position = position - 1
    save!
  end
  
  # ------------------------------------------------------------------
  private
  
  def set_position
    good.options.any? ? assume_lowest_position : self.position = 1
  end
  
  def assume_lowest_position
    lowest_option = good.options.in_order.last
    self.position = lowest_option.position + 1
  end
  
  def shift_lower_positioned_options_higher
    Option.transaction do
      for option in good.options.where( "options.position > #{ position }" ).all
        option.shift_higher
      end
    end
  end
  
  def update_good_variants_with_default_value
    good.variants.update_all( :"option_value_#{ position }" => default_value )
  end
  
  def good_has_less_than_5_options
    errors.add( :good, "cannot have more than 5 options" ) if good and good.options.count == 5
  end
  
  def ensure_not_last_option
    return false if good.options.count == 1
  end
end
