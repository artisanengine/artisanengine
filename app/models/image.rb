# Images represent an image file which can be associated with a model
# through an image attacher.
class Image < ActiveRecord::Base
  attr_accessible :image
  image_accessor  :image do
    storage_path :storage_filename
  end
  
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
  private
  
  # Store files under the frame domain with a month/day/year timestamp
  # and a URL-safe random token.
  def storage_filename
    "#{ frame.domain }" +
    "/images/" + 
    "#{ Time.now.strftime( "%m_%d_%Y" ) }" +
    "_#{ ActiveSupport::SecureRandom.urlsafe_base64( 5 ) }_" +
    "#{ image_name }"
  end
  
end