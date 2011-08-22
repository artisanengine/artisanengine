# A good is an item sold by an artisan. It can have variations (variants) 
# the potential properties of which are determined by its options.
class Good < ActiveRecord::Base
  attr_accessible :name, :description, :short_description, :available
  
  has_friendly_id :name, use_slug: true, scope: :frame
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_save  :convert_description_to_html
  after_create :create_first_option_and_variant
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  has_many   :collects,                                   dependent: :destroy
  has_many   :display_cases,   through: :collects
  has_many   :image_attachers, as:      :imageable,       dependent: :destroy
  has_many   :images,          through: :image_attachers
  has_many   :options,                                    dependent: :destroy
  has_many   :variants,                                   dependent: :destroy
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :name, :frame
  
  # ------------------------------------------------------------------
  # Methods
  
  # Returns true if the item has more than one option or more than one
  # variant.
  def has_variation?
    return true if options.count > 1 or variants.count > 1
    return true if options.first.name != "Type"
    return true if variants.first.option_value_1 != "Default"
  end
  
  # Retrieves all a good's images in their proper display order.
  def images_in_display_order
    Image.joins( :image_attachers )
         .where( "image_attachers.imageable_type = 'Good' AND image_attachers.imageable_id = ?", id )
         .order( "image_attachers.display_order ASC" )
  end
  
  # ------------------------------------------------------------------
  private
  
  # Create a 'Type' option with a 'Default' first option value.
  def create_first_option_and_variant
    options.create!  name: 'Type', default_value: 'Default'
    variants.create! option_value_1: 'Default', price: 100
  end
  
  # Convert the good's description from Textile to HTML.
  def convert_description_to_html
    self.html_description = ArtisanEngine::Textiling.textile( description )
  end
end
