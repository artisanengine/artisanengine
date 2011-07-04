class Post < ActiveRecord::Base
  attr_accessible :title, :content, :tag_names
  attr_accessor   :tag_names
  
  # ------------------------------------------------------------------
  # Callbacks
  
  before_save :convert_content_to_html
  after_save  :convert_tag_names_to_tag_associations
  
  # ------------------------------------------------------------------
  # Associations
  
  belongs_to :blog
  has_many   :taggings, :as      => :taggable, dependent: :destroy
  has_many   :tags,     :through => :taggings
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of :title, :blog
    
  # ------------------------------------------------------------------
  # Accessors
  
  def tag_names
    @tag_names || tags.map( &:name ).join( ', ' )
  end
  
  # ------------------------------------------------------------------
  private
  
  def convert_content_to_html
    self.html_content = ArtisanEngine::Textiling.textile( self.content )
  end
  
  def convert_tag_names_to_tag_associations
    if tag_names
      self.tags = tag_names.split( ',' ).map do |tag_name|
        # Trim any beginning-of-string whitespace and create a Tag from the tag name.
        # Also sub out any (new) text, as this is added by TokenInput if a tag doesn't exist.
        Tag.find_or_create_by_name( tag_name.gsub( /\A\s+/, '' )
                                            .gsub( ' (new)', '' ), frame: blog.frame )
      end
    end
  end
end