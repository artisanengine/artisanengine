# Options (Size, Color, Material, etc.) belong to a good and
# represent "building blocks" for that good's variants. They
# also contain logic for automatically managing a good's variants as
# they are created, destroyed, or re-organized, which is probably a 
# very bad thing and should be refactored out ASAP.
class Option < ActiveRecord::Base
  attr_accessible :name, :default_value
  
  # ------------------------------------------------------------------
  # Callbacks
  
  after_create          :update_good_variants_with_default_value
  before_destroy        :ensure_not_last_option
  before_destroy        :update_variant_values
  
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
  # Methods
  
  # This makes me feel dirty. I have done a bad thing. But until 
  # I can figure out a better way, this returns all its parent 
  # good's variants.
  def associated_variants
    good.variants
  end
  
  # Returns a string that matches the option's related 
  # column in a variant model.
  def variant_column
    "option_value_#{ order_in_good }"
  end
  
  def higher_positioned_options
    good.options.where( "options.order_in_good > #{ order_in_good }" ).all
  end
  
  # ------------------------------------------------------------------
  private
  
  # Add an error if the option's good has 5 options.
  def good_has_less_than_5_options
    errors.add :good, "cannot have more than 5 options" if good and good.options.count == 5
  end
  
  # Return false if this is the the good's only option.
  def ensure_not_last_option
    return false if good.options.count == 1
  end
  
  # ------------------------------------------------------------------
  # Variant Management Functions
  #
  # These functions determine what to do with an option's associated
  # good's variants at various points in the option lifecycle.
  # I have a sinking feeling that doing things this way is a train wreck
  # and will refactor as I learn how to write decent software.
  
  # Determine what is to be done with the variants of a deleted option.
  def update_variant_values
    higher_positioned_options.any? ? shift_variant_values : nullify_variant_values
  end
  
  # When an option is destroyed and has other options above it, 
  # this method gets all the variants from its parent good and shifts 
  # their position by updating the necessary database columns.
  def shift_variant_values
    Option.transaction do
      for higher_option in higher_positioned_options
        current_column = higher_option.variant_column
        target_column  = "option_value_#{ higher_option.order_in_good - 1 }"
      
        higher_option_variants = higher_option.associated_variants
      
        # Shift their values lower.
        higher_option_variants.update_all( "#{ target_column } = #{ current_column }" )
        higher_option_variants.update_all( "#{ current_column } = NULL" )
      end
    end
  end
  
  # When an option is destroyed and does not have other options above it,
  # this method simply nullifies its good's variants column for those 
  # values.
  def nullify_variant_values
    associated_variants.update_all( "#{ variant_column } = NULL" )
  end

  # Updates the option's parent good's variants' appropriate column with its default value.
  def update_good_variants_with_default_value
    associated_variants.update_all [ "#{ variant_column } = ?", default_value ]
  end
end
