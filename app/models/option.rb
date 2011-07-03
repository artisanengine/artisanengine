class Option < ActiveRecord::Base
  attr_accessible :name, :default_value
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_create :set_position
  after_create  :update_good_variants_with_default_value
  
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
  private
  
  def set_position
    good.options.any? ? assume_lowest_position : self.position = 1
  end
  
  def assume_lowest_position
    lowest_option = good.options.in_order.last
    self.position = lowest_option.position + 1
  end
  
  def update_good_variants_with_default_value
    good.variants.update_all( :"option_value_#{ position }" => default_value )
  end
  
  def good_has_less_than_5_options
    errors.add( :good, "cannot have more than 5 options" ) if good and good.options.count == 5
  end
end
