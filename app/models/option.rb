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
  
  # ------------------------------------------------------------------
  private
  
  def set_position
    self.position = 1
  end
  
  def update_good_variants_with_default_value
    good.variants.update_all( :"option_value_#{ position }" => default_value )
  end
end
