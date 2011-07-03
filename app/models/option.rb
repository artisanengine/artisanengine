class Option < ActiveRecord::Base
  attr_accessible :name, :default_value
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_create         :set_position
  after_create          :update_good_variants_with_default_value
  before_destroy        :ensure_not_last_option
  after_destroy         :clear_good_variants_option_values
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
    Option.transaction do
      for variant in good.variants
        eval( "variant.option_value_#{ position - 1 } = variant.option_value_#{ position }" )
        eval( "variant.option_value_#{ position } = nil" )
        variant.save
      end
    
      self.position = position - 1
      save!
    end
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
  
  def clear_good_variants_option_values
    good.variants.update_all( :"option_value_#{ position }" => nil )
  end
end
