# Options (Size, Color, Material, etc.) belong to a good and
# represent "building blocks" for that good's variants. They
# also contain logic for automatically managing a good's variants as
# they are created, destroyed, or re-organized.
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
  
  # When an option is destroyed, this method gets all the variants from
  # its parent good and shifts their position by updating the necessary
  # database columns. Yes, I know this is awful and needs surgery.
  def shift_variant_values
    Option.transaction do
      # If there are any higher-positioned options in the good ...
      if good.options.where( "options.order_in_good > #{ order_in_good }" ).any?
        # Shift their values lower.
        for option in good.options.where( "options.order_in_good > #{ order_in_good }" ).all
          option.good.variants.update_all( "option_value_#{ option.order_in_good - 1 } = option_value_#{ option.order_in_good }" )
          option.good.variants.update_all( "option_value_#{ option.order_in_good } = NULL" )
        end
      # If this is the highest-positioned option in the good ...
      else
        # Nullify all its values.
        good.variants.update_all( "option_value_#{ order_in_good } = NULL" )
      end
    end
  end
  
  # Updates the option's parent good's variants' appropriate column with its default value.
  # Yes, I know this is awful and needs surgery.
  def update_good_variants_with_default_value
    good.variants.update_all [ "option_value_#{ order_in_good } = ?", default_value ]
  end
  
  # Add an error if the option's good has 5 options.
  def good_has_less_than_5_options
    errors.add :good, "cannot have more than 5 options" if good and good.options.count == 5
  end
  
  # Return false if this is the the good's only option.
  def ensure_not_last_option
    return false if good.options.count == 1
  end
end
