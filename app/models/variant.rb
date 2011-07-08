class Variant < ActiveRecord::Base
  # ------------------------------------------------------------------
  # Callbacks
  
  before_destroy        :ensure_not_last_variant
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :good
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :good
  validate              :correct_number_of_option_values
  validate              :no_required_option_value_can_be_blank
  
  # ------------------------------------------------------------------
  # Accessors
  
  def option_values
    [ option_value_1, option_value_2, option_value_3, option_value_4, option_value_5 ]
  end
  
  def number_of_options
    option_values.compact.count
  end
  
  def required_number_of_options
    return nil unless good
    good.options.count
  end
  
  def values_to_s
    values_string = ""
    
    option_values.each_with_index do |value, index|      
      unless index == number_of_options - 1
        values_string << "#{ value } / " unless value.blank?
      else
        values_string << "#{ value}"     unless value.blank?
      end
    end
    
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
    return false if good.variants.count == 1
  end
  
end
