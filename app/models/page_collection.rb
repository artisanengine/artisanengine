class PageCollection < ActiveRecord::Base
  has_friendly_id :name, use_slug: true, scope: :frame
  
  belongs_to :frame
  validates_presence_of :frame, :name
  has_many :page_collects
  has_many :pages, through: :page_collects
  
  # ------------------------------------------------------------------
  # Methods
  
  def pages_in_display_order
    pages.order( "page_collects.display_order ASC" )
  end
end
