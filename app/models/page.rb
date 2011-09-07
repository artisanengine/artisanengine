# A page is a basic container for static information.
class Page < ActiveRecord::Base
  attr_accessible :title, :content
  
  has_friendly_id :title, use_slug: true, scope: :frame
  
  has_many :page_collects
  has_many :page_collections, through: :page_collects
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_save :convert_content_to_html
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :title, :frame
  
  # ------------------------------------------------------------------
  private
  
  def convert_content_to_html
    self.html_content = ArtisanEngine::Textiling.textile( self.content )
  end
end
