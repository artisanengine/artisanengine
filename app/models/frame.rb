# Frames represent one artisan's website. They primarily act as a scope
# to enforce separation between models based on which artisan they
# belong to.
class Frame < ActiveRecord::Base
  attr_accessible :name, :domain
  
  # ------------------------------------------------------------------
  # Callbacks
  
  after_create          :initialize_blog
  after_create          :initialize_featured_display_case
  
  # ------------------------------------------------------------------
  # Associations
  
  has_many :artisans,      dependent: :destroy
  has_many :display_cases, dependent: :destroy
  has_many :goods,         dependent: :destroy
  has_many :images,        dependent: :destroy
  has_many :orders,        dependent: :destroy
  has_many :pages,         dependent: :destroy
  has_many :patrons,       dependent: :destroy
  has_many :settings,      dependent: :destroy
  has_many :tags,          dependent: :destroy
  has_many :promotions,    dependent: :destroy
  
  has_one  :blog,          dependent: :destroy
  has_one  :featured_case, class_name: 'DisplayCase', 
                           conditions: [ 'display_cases.name = ?', 'Featured' ]
  
  # ------------------------------------------------------------------
  # Validations
  
  validates_presence_of   :name, :domain
  validates_uniqueness_of :domain
  
  # ------------------------------------------------------------------
  private
  
  # Create a blog within the frame with a name based on the frame's name.
  def initialize_blog
    create_blog name: "#{ name } Blog"
  end
  
  # Create a Featured display case within the frame.
  def initialize_featured_display_case
    display_cases.create! name: "Featured"
  end
end
