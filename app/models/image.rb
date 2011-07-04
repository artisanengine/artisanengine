class Image < ActiveRecord::Base
  attr_accessible :image
  
  image_accessor :image do
    storage_path :storage_filename
  end
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  has_many   :image_attachers, dependent: :destroy
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :image, :frame
  
  validates_format_of   :image_name, 
                          with: /^[\w-]+\.[a-zA-Z]{3,4}$/
  
  validates_property    :format, of: :image, 
                          in: [ :jpg, :jpeg, :png, :gif ]
  
  # ------------------------------------------------------------------
  private
  
  # Store files under the frame domain with a unique timestamp.
  def storage_filename
    "#{ frame.domain }" +
    "/images/" + 
    "#{ image_name }" +
    "_#{ Time.now.strftime( "%m_%d_%Y" ) }_#{ Time.now.to_i.to_s }"
  end
  
end