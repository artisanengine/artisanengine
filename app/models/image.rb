# Images represent an image file which can be associated with a model
# through an image attacher.
class Image < ActiveRecord::Base
  attr_accessor   :crop_x, :crop_y, :crop_w, :crop_h, :crop_priority
  attr_accessible :image, :name, :crop_x, :crop_y, :crop_w, :crop_h, :crop_priority
  
  serialize :primary_cropping
  serialize :secondary_cropping
  
  image_accessor  :image do
    storage_path :storage_filename
  end
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_save :save_crop_values, if: :cropping?
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :image_attachers, dependent: :destroy
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_format_of   :image_name, with: /^[\w-]+\.[a-zA-Z]{3,4}$/
  validates_presence_of :image, :frame
  validates_property    :format, of: :image, in: [ :jpg, :png, :gif ]
  validates_size_of     :image, maximum: 2.megabytes
  
  # ------------------------------------------------------------------
  # Methods
  
  # Returns the custom name if it exists, otherwise returns the image's
  # filename.
  def name_or_filename
    name.blank? ? image_name : name
  end
    
  # ------------------------------------------------------------------
  private
  
  # Store files under the frame domain with a month/day/year timestamp
  # and a URL-safe random token.
  def storage_filename
    "#{ frame.domain }" +
    "/images/" + 
    "#{ Time.now.strftime( "%m_%d_%Y" ) }" +
    "_#{ SecureRandom.urlsafe_base64( 5 ) }_" +
    "#{ image_name }"
  end
  
  # True if all the crop values and the crop priority are set.
  def cropping?
    !crop_x.blank? and !crop_y.blank? and !crop_w.blank? and !crop_h.blank?
  end
  
  # Saves the primary_cropping or secondary_cropping based on the crop_priority.
  def save_crop_values
    crop_values = [ crop_x, crop_y, crop_w, crop_h ]
    
    case crop_priority
    when 'primary'
      self.primary_cropping = crop_values
    when 'secondary'
      self.secondary_cropping = crop_values
    else
      errors.add :base, "Cannot crop without setting a crop priority." and return false
    end
  end
end