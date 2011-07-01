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
  
  before_save :convert_content_to_html
  
  private
  
  def convert_content_to_html
    self.html_content = RedCloth.new( content, [ :filter_html ] ).to_html.html_safe
  end
end
