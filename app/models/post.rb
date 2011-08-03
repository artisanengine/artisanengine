# Another fairly basic container, similar to a page. Its differences are
# that it must belong to a blog and it can have tags for organizational
# purposes.
class Post < ActiveRecord::Base
  attr_accessible :title, :content, :tag_names, :published_on
  attr_accessor   :tag_names
  
  has_friendly_id :title, use_slug: true, scope: :blog
  
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
  # Scopes
  
  scope :by_year,            lambda { |year| 
                               year = Date.new( year.to_i )
                               where created_at: year.beginning_of_year..year.beginning_of_year.next_year 
                             }
                             
  scope :by_month,           lambda { |year, month| 
                               month = Date.new( year.to_i, month.to_i )
                               where created_at: month.beginning_of_month..month.beginning_of_month.next_month 
                              }
    
  scope :published,          lambda { where( [ "posts.published_on IS NOT NULL AND posts.published_on <= ?", Time.now ] ) }
  scope :tagged_with,        lambda { |tag_name| joins( :tags ).where( "tags.name = ?", tag_name ) }
  scope :descending_by_date, lambda { order( "posts.published_on DESC" ) }
  
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
  
  # Make or assign existing Tag objects based on the string given to tag_names.
  # man, bear pig, crocodile will make three new tags and associate them with the post
  # (unless any of them already exist, in which case it will use the existing tags).
  def convert_tag_names_to_tag_associations
    if tag_names
      self.tags = tag_names.split( ',' ).map do |tag_name|
        # Trim any beginning-of-string whitespace and create a Tag from the tag name.
        # Also sub out any (new) text, as this is added by TokenInput if a tag doesn't exist.
        new_tag = Tag.find_or_initialize_by_name( tag_name.gsub( /\A\s+/, '' )
                                                          .gsub( ' (new)', '' ) )
        new_tag.frame = blog.frame
        new_tag.save!
        new_tag
      end
    end
  end
end