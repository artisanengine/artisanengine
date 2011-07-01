class Post < ActiveRecord::Base
  attr_accessible :title, :content
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :blog
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :title, :content, :blog
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_save :convert_content_to_html
  
  private
  
  def convert_content_to_html
    self.html_content = ArtisanEngine::Textiling.textile( self.content )
  end
end