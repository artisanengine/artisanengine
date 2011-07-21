class Good < ActiveRecord::Base
  attr_accessible :name, :description
  
  has_friendly_id :name, use_slug: true, scope: :frame
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_save  :convert_description_to_html
  after_create :create_first_option_and_variant
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :options,                                    dependent: :destroy
  has_many   :variants,                                   dependent: :destroy
  has_many   :image_attachers, as:      :imageable,       dependent: :destroy
  has_many   :images,          through: :image_attachers
  has_many   :collects,                                   dependent: :destroy
  has_many   :display_cases,   through: :collects
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
  
  # ------------------------------------------------------------------
  # Methods
  
  def has_variation?
    true if options.count > 1 or variants.count > 1
  end
  
  # ------------------------------------------------------------------
  private
  
  def create_first_option_and_variant
    options.create!  name: 'Type', default_value: 'Default'
    variants.create! option_value_1: 'Default', price: 100
  end
  
  def convert_description_to_html
    self.html_description = ArtisanEngine::Textiling.textile( self.description )
  end
end
