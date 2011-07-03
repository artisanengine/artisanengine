class Good < ActiveRecord::Base
  attr_accessible :name, :description
  
  # ------------------------------------------------------------------
  # Callbacks
  
  after_create :create_first_variant
  after_create :create_default_option
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :options
  has_many   :variants
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
  
  # ------------------------------------------------------------------
  private
  
  def create_first_variant
    variants.create!
  end
  
  def create_default_option
    options.create! name: 'Type', default_value: 'Default'
  end
end
