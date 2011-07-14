class Option < ActiveRecord::Base
  attr_accessible :name, :default_value
  
  # ------------------------------------------------------------------
  # Callbacks
  
  after_create          :update_good_variants_with_default_value
  before_destroy        :ensure_not_last_option
  before_destroy        :shift_variant_values
  
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
  # Scopes

  scope :in_order, lambda { order( "options.order_in_good ASC" ) }
  
  # ------------------------------------------------------------------
  private
    
  def shift_variant_values
    Option.transaction do
      for option in good.options.where( "options.order_in_good > #{ order_in_good }" ).all
        option.good.variants.update_all( "option_value_#{ option.order_in_good - 1 } = option_value_#{ option.order_in_good }" )
        option.good.variants.update_all( "option_value_#{ option.order_in_good } = NULL" )
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
