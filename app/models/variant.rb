class Variant < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Callbacks
  
  before_destroy        :ensure_not_last_variant
  
  # ------------------------------------------------------------------
  # Money
  
  composed_of :price, class_name:  "Money",
                      mapping:     [ %w(price_in_cents cents), %w(currency currency_as_string) ],
                      constructor: lambda { |cents, currency| Money.new( cents || 0, currency || Money.default_currency ) },
                      converter:   lambda { |value| value.respond_to?( :to_money ) ? value.to_money : 0.to_money }
  
  # ------------------------------------------------------------------
  # Positioning
  
  include RankedModel
  ranks :display_order, with_same: :good_id
  
  # ------------------------------------------------------------------
  # Associations & Delegations
  
  belongs_to :good
  delegate   :name, to: :good
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of     :good
  validates_numericality_of :price, greater_than_or_equal_to: 1
  validate                  :correct_number_of_option_values
  validate                  :no_required_option_value_can_be_blank
  
  # ------------------------------------------------------------------
  # Accessors
  
  # Return an array of the variant's option values.
  def option_values
    [ option_value_1, option_value_2, option_value_3, option_value_4, option_value_5 ]
  end
  
  # Return the number of set option values.
  def number_of_options
    option_values.compact.count
  end
  
  # Return how many options need to be set for a valid variant - derived from how many
  # options the parent good has.
  def required_number_of_options
    return nil unless good
    good.options.count
  end
  
  # Create a slash-separated string of option values ( "Small / Red / Cloth" ), with
  # optional price ( "Small / Red / Cloth -- $25.00" ).
  def values_to_s( with_price = true )
    values_string = ""
    return values_string if number_of_options == 1 and option_value_1 == "Default"
    
    option_values.each_with_index do |value, index|      
      unless index == number_of_options - 1
        values_string << "#{ value } / " unless value.blank?
      else
        values_string << "#{ value }"    unless value.blank?
      end
    end
    
    values_string << " -- #{ price.format }" if with_price
    values_string
  end
  
  # ------------------------------------------------------------------
  private
  
  def correct_number_of_option_values
    errors.add( :base, "#{ number_of_options } options were given, but #{ required_number_of_options } are required." ) if number_of_options != required_number_of_options
  end
  
  def no_required_option_value_can_be_blank
    return unless required_number_of_options
    required_number_of_options.times do |time|
      errors.add( :"option_value_#{ time + 1 }", "cannot be blank." ) if eval( "option_value_#{ time + 1 }.blank?" )
    end
  end
  
  def ensure_not_last_variant
    errors.add :base, "Can't delete a good's last variant." and return false if good.variants.count == 1
  end
  
end
