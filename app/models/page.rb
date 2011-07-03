class Page < ActiveRecord::Base
  attr_accessible :title, :content
  
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
