class Page < ActiveRecord::Base
  attr_accessible :title, :content
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :frame
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :title, :content, :frame
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_save :convert_content_from_textile_to_html
  
  private
  
  def convert_content_from_textile_to_html
    self.content = RedCloth.new( content ).to_html
  end
end
