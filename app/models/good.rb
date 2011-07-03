class Good < ActiveRecord::Base
  attr_accessible :name, :description
  
  # ------------------------------------------------------------------
  # Callbacks
  
  after_create :create_first_option_and_variant
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :options
  has_many   :variants
  has_many   :image_attachers, :as      => :imageable
  has_many   :images,          :through => :image_attachers
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
  
  # ------------------------------------------------------------------
  private
  
  def create_first_option_and_variant
    options.create!  name: 'Type', default_value: 'Default'
    variants.create! option_value_1: 'Default'
  end
end
